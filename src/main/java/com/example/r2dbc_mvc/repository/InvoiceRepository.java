package com.example.r2dbc_mvc.repository;

import com.example.r2dbc_mvc.model.Invoice;
import com.example.r2dbc_mvc.model.custom_query_return.MonthSale;
import com.example.r2dbc_mvc.model.custom_query_return.ProfitOnEachProduct;
import com.example.r2dbc_mvc.model.custom_query_return.SalesCostMonthYear;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public interface InvoiceRepository extends R2dbcRepository<Invoice, Integer> {
    @Query(value = "select max(value) from invoice;")
    Mono<Float> findMaxValue();

    @Query(value="select S.sales sales_, Ch.costs costs_,S.month month_,S.year year_\n" +
            "from (select SUM(value) as sales,\n" +
            "        EXTRACT(month from invoice_date) as month,\n" +
            "        EXTRACT(year from invoice_date) as year \n" +
            "        from invoice \n" +
            "        where type='c'\n" +
            "        group by EXTRACT(month from invoice_date),EXTRACT(year from invoice_date)) S\n" +
            "    full join (select SUM(value) as costs,\n" +
            "        EXTRACT(month from invoice_date) as month,\n" +
            "        EXTRACT(year from invoice_date) as year\n" +
            "        from invoice \n" +
            "        where type='s'\n" +
            "        group by EXTRACT(month from invoice_date), EXTRACT(year from invoice_date)) Ch\n" +
            "    on S.month = Ch.month and S.year=Ch.year\n" +
            "    order by S.year, S.month;")
    Flux<SalesCostMonthYear> findSalesCostMonthYear();

    @Query(value="select S.prod_name, (S.sales - C.costs) Profit\n" +
            "from (select p.prod_name prod_name, sum(i.quantity * i.unit_price) sales\n" +
            "    from item i inner join products p on i.id_prod = p.id_prod\n" +
            "        inner join invoice inv on inv.nr = i.invoice_nr and inv.invoice_date = i.invoice_date\n" +
            "        where inv.type = 'c'\n" +
            "        group by i.id_prod,p.prod_name) S \n" +
            "    inner join \n" +
            "    (select p.prod_name prod_name, sum(i.quantity * i.unit_price) costs\n" +
            "    from item i inner join products p on i.id_prod = p.id_prod\n" +
            "        inner join invoice inv on inv.nr = i.invoice_nr and inv.invoice_date = i.invoice_date\n" +
            "        where inv.type = 's'\n" +
            "        group by i.id_prod,p.prod_name) C \n" +
            "    on S.prod_name = C.prod_name \n" +
            "order by S.prod_name;")
    Flux<ProfitOnEachProduct> findProfitOnEachProduct();

    @Query(value = "select S.month, S.sales \n" +
            "from (select SUM(value) as sales,\n" +
            "            EXTRACT(month from invoice_date) as month,\n" +
            "            EXTRACT(year from invoice_date) as year\n" +
            "        from invoice \n" +
            "        where type='c'\n" +
            "        group by EXTRACT(month from invoice_date),EXTRACT(year from invoice_date)) S\n" +
            "    left join (select SUM(value) as sales,\n" +
            "            EXTRACT(month from invoice_date) as month,\n" +
            "            EXTRACT(year from invoice_date) as year\n" +
            "        from invoice \n" +
            "        where type='c'\n" +
            "        group by EXTRACT(month from invoice_date),EXTRACT(year from invoice_date)) S2\n" +
            "on S.sales < S2.sales\n" +
            "where S2.month is null;")
    Flux<MonthSale> getMonthWithGreatestSales();
}
