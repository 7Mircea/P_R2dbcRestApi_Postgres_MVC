package com.example.r2dbc_mvc.repository;

import com.example.r2dbc_mvc.model.CustomerEmployeeSupplier;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

public interface CustomerEmployeeSupplierRepository extends R2dbcRepository<CustomerEmployeeSupplier,Integer> {
    @Query("select * from customer_employee_supplier where type_ces=:c")
    Flux<CustomerEmployeeSupplier> findCustomerEmployeeSupplierByTypeCES(char c);

    @Query(value = "select CES.Name\n" +
            "from (select count(*) invoice_number, id_employee\n" +
            "    from invoice\n" +
            "    group by id_employee) S inner join CUSTOMER_EMPLOYEE_SUPPLIER CES on S.id_employee = CES.id_ces\n" +
            "where invoice_number = (select max(S2.invoice_number) \n" +
            "                    from (select count(*) invoice_number, id_employee\n" +
            "                        from invoice\n" +
            "                        group by id_employee) S2);\n")
    Flux<String> findEmployeeWithGreatestNrOfInvoices();
}
