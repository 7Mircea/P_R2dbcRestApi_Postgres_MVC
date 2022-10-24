package com.example.r2dbc_mvc.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import static com.example.r2dbc_mvc.utils.Constants.CUSTOMER_EMPLOYEE_SUPPLIER_TABLE;


@Data
@Table(value = CUSTOMER_EMPLOYEE_SUPPLIER_TABLE)
public class CustomerEmployeeSupplier {
    @Id
    @Column(value = "id_ces")
    private int idCES;
    @Column
    private String name;
    @Column
    private String EIN;
    @Column(value = "type_ces")
    private char typeCES;
    private String address;
    @Column
    private String IBAN;
    private String SSN;
}
