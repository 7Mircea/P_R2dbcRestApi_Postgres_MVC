package com.example.r2dbc_mvc.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;

@Table
@Data
public class Item {

    @Column("invoice_nr")
    private int invoiceNr;
    @Column("invoice_date")
    private LocalDate invoiceDate;
    @Column(value = "id_item")
    private int idItem;
    @Column(value = "id_prod")
    private int idProd;
    private String unit;
    private int quantity;
    @Column(value = "unit_price")
    private float unit_price;
}
