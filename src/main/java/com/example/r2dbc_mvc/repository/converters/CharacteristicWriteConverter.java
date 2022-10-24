package com.example.r2dbc_mvc.repository.converters;

import com.example.r2dbc_mvc.model.Characteristic;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.r2dbc.mapping.OutboundRow;
import org.springframework.data.r2dbc.mapping.SettableValue;
//import org.springframework.r2dbc.core.Parameter;
public class CharacteristicWriteConverter {
}

//public class CharacteristicWriteConverter implements Converter<Characteristic,OutboundRow> {
//    @Override
//    public OutboundRow convert(Characteristic source) {
//        OutboundRow out = new OutboundRow();
//        out.put("id_prod", Parameter.from(source.getIdProd())) ;
//        out.put("id_characteristic", Parameter.from(source.getIdCharacteristic()));
//        out.put("name",Parameter.from(source.getName()));
//        out.put("value",Parameter.from(source.getValue()));
//        return out;
//    }
//}
