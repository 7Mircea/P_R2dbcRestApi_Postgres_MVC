package com.example.r2dbc_mvc.repository;

import com.example.r2dbc_mvc.model.Item;
import com.example.r2dbc_mvc.model.custom_query_return.ProdQuantity1;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

public interface ItemRepository extends R2dbcRepository<Item,Integer> {
    @Query(value = "select p.prod_name,idProdQ.quantity from products p inner join (select i.id_prod id_prod,sum(i.quantity) quantity\n" +
            "from item i inner join invoice on i.invoice_nr = invoice.nr and i.invoice_Date = invoice.invoice_Date\n" +
            "where EXTRACT(month from invoice.invoice_Date) = 10 and EXTRACT(year from invoice.invoice_Date) = 2022 and invoice.type='c'\n" +
            "group by i.id_prod) idProdQ on p.id_prod=idProdQ.id_prod;")
    Flux<ProdQuantity1> findItemsBetweenDates();
}
