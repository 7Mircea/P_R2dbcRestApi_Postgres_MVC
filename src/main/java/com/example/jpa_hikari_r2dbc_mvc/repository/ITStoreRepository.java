package com.example.jpa_hikari_r2dbc_mvc.repository;

import com.example.jpa_hikari_r2dbc_mvc.model.Products;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface ITStoreRepository extends ReactiveCrudRepository<Products,Integer> {
}
