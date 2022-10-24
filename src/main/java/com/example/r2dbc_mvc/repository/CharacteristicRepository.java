package com.example.r2dbc_mvc.repository;

import com.example.r2dbc_mvc.model.Characteristic;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

public interface CharacteristicRepository extends R2dbcRepository<Characteristic, Long> {
    @Query("select * from characteristic where id_prod=:idProd")
    Flux<Characteristic> findCharacteristicByIdProd(Integer idProd);
}
