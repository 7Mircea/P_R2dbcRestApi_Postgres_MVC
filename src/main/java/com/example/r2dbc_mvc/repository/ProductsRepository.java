package com.example.r2dbc_mvc.repository;

import com.example.r2dbc_mvc.model.Products;
import com.example.r2dbc_mvc.model.custom_query_return.CategoryProductProfit;
import com.example.r2dbc_mvc.model.custom_query_return.CategoryProfit;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

public interface ProductsRepository extends R2dbcRepository<Products,Integer> {
    @Query(value = "select distinct on (SS.category) category, SS.Product_name, SS.Profit\n" +
            "from (select S.category, S.prod_name Product_name, (S.sales - C.costs) Profit\n" +
            "    from (select p.category category, p.prod_name prod_name, sum(i.quantity * i.unit_price) sales\n" +
            "        from item i inner join products p on i.id_prod = p.id_prod\n" +
            "            inner join invoice inv on inv.nr = i.invoice_nr and inv.invoice_date = i.invoice_date\n" +
            "            where inv.type = 'c'\n" +
            "            group by i.id_prod,p.prod_name,p.category) S \n" +
            "        inner join \n" +
            "        (select p.prod_name prod_name, sum(i.quantity * i.unit_price) costs\n" +
            "        from item i inner join products p on i.id_prod = p.id_prod\n" +
            "            inner join invoice f on f.nr = i.invoice_nr and f.invoice_date = i.invoice_date\n" +
            "            where f.type = 's'\n" +
            "            group by i.id_prod,p.prod_name) C \n" +
            "        on S.prod_name = C.prod_name \n" +
            "    order by S.prod_name) SS\n" +
            "where SS.Profit = (select Max((S.sales - C.costs)) Profit\n" +
            "                    from (select p.prod_name prod_name, p.category category, sum(i.quantity * i.unit_price) sales\n" +
            "                        from item i inner join products p on i.id_prod = p.id_prod\n" +
            "                            inner join invoice f on f.nr = i.invoice_nr and f.invoice_date = i.invoice_date\n" +
            "                            where f.type = 'c' and p.category = SS.category\n" +
            "                            group by i.id_prod,p.prod_name,p.category) S \n" +
            "                        inner join \n" +
            "                        (select p.prod_name prod_name, sum(i.quantity * i.unit_price) costs\n" +
            "                        from item i inner join products p on i.id_prod = p.id_prod\n" +
            "                            inner join invoice f on f.nr = i.invoice_nr and f.invoice_date = i.invoice_date\n" +
            "                            where f.type = 's' and p.category = SS.category\n" +
            "                            group by i.id_prod,p.prod_name) C \n" +
            "                        on S.prod_name = C.prod_name \n" +
            "                    group by S.category);")
    Flux<CategoryProductProfit> getProductWithGreatestProfitInCategory();

    @Query(value = "select S.category, sum(S.sales - C.costs) Profit\n" +
            "from (select p.category category, p.prod_name prod_name, sum(i.quantity * i.unit_price) sales\n" +
            "    from item i inner join products p on i.id_prod = p.id_prod\n" +
            "        inner join invoice f on f.nr = i.invoice_nr and f.invoice_date = i.invoice_date\n" +
            "        where f.type = 'c'\n" +
            "        group by i.id_prod, p.prod_name, p.category) S \n" +
            "    inner join \n" +
            "    (select p.prod_name prod_name, sum(i.quantity * i.unit_price) costs\n" +
            "    from item i inner join products p on i.id_prod = p.id_prod\n" +
            "        inner join invoice inv on inv.nr = i.invoice_nr and inv.invoice_date = i.invoice_date\n" +
            "        where inv.type = 's'\n" +
            "        group by i.id_prod,p.prod_name) C \n" +
            "    on S.prod_name = C.prod_name \n" +
            "group by category\n" +
            "order by category;")
    Flux<CategoryProfit> findProfitForEachCategory();
}
