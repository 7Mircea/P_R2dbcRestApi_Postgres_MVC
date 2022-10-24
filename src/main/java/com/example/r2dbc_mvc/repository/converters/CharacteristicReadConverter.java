package com.example.r2dbc_mvc.repository.converters;

import com.example.r2dbc_mvc.model.Characteristic;
import io.r2dbc.spi.Row;
import org.springframework.core.convert.converter.Converter;

public class CharacteristicReadConverter implements Converter<Row, Characteristic> {
    /**
     * The id for Characteristic POJO is transient, that means is not stored in the database
     * In order to create it I know from the dataset that there aren't more than 65536(1<<16) characteristics,
     * so I concatenate at bit level the idProd and idCharacteristic in a single number.
     *
     * @param source is the row from the database
     * @return new Characteristic POJO
     */
    @Override
    public Characteristic convert(Row source) {
        Integer idProd = source.get("id_prod", Integer.class);
        Integer idCharacteristic = source.get("id_characteristic", Integer.class);
        if (idCharacteristic != null && idProd != null)
//            return new Characteristic((idProd.longValue() << 16L) + idCharacteristic.longValue(), idProd, idCharacteristic, source.get("name", String.class), source.get("value", String.class));
            return new Characteristic(idProd,idCharacteristic,source.get(3,String.class),source.get(4,String.class));
        else return null;
    }


}
