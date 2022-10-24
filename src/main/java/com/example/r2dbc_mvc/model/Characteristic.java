package com.example.r2dbc_mvc.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@Table
@AllArgsConstructor
public class Characteristic {
    @Column("id_prod")
    private Integer idProd;
    @Column(value = "id_characteristic")
    private Integer idCharacteristic;
    @Column
    private String name;
    @Column
    private String value;

    @Override
    public String toString() {
        return new StringBuilder()
                .append("Characteristic : ")
                .append(idProd)
                .append(',')
                .append(idCharacteristic)
                .append(',')
                .append(name)
                .append(',')
                .append(value)
                .append('\n')
                .toString();
    }
}


