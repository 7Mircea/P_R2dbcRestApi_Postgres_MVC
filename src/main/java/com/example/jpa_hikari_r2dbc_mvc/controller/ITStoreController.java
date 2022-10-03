package com.example.jpa_hikari_r2dbc_mvc.controller;

import com.example.jpa_hikari_r2dbc_mvc.model.Products;
import com.example.jpa_hikari_r2dbc_mvc.repository.ITStoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.scheduler.Schedulers;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/itStore")
public class ITStoreController {

    @Autowired
    ITStoreRepository repository;

    @GetMapping("/products")
    public List<Products> getAllProducts() {
        return repository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/{id}")
    public Optional<Products> getProductById(@PathVariable Integer id) {
        return repository.findById(id).subscribeOn(Schedulers.boundedElastic()).blockOptional();
    }

}
