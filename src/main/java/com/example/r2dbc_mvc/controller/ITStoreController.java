package com.example.r2dbc_mvc.controller;

import com.example.r2dbc_mvc.model.*;
import com.example.r2dbc_mvc.model.custom_query_return.*;
import com.example.r2dbc_mvc.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.scheduler.Schedulers;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/itStore")
public class ITStoreController {

    @Autowired
    ProductsRepository productsRepository;
    @Autowired
    CharacteristicRepository characteristicRepository;
    @Autowired
    CustomerEmployeeSupplierRepository customerEmployeeSupplierRepository;
    @Autowired
    InvoiceRepository invoiceRepository;
    @Autowired
    ItemRepository itemRepository;

    @GetMapping("/products")
    public List<Products> getAllProducts() {
        return productsRepository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/{id}")
    public Optional<Products> getProductById(@PathVariable Integer id) {
        return productsRepository.findById(id).subscribeOn(Schedulers.boundedElastic()).blockOptional();
    }
    @GetMapping("/product_max_profit")
    public Iterable<CategoryProductProfit> getProductWithMaxProfit() {
        return productsRepository.getProductWithGreatestProfitInCategory().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }
    @GetMapping("/category_profit")
    public Iterable<CategoryProfit> getCategoryProfit() {
        return productsRepository.findProfitForEachCategory().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/characteristics")
    public Iterable<Characteristic> getAllCharacteristics() {
        return characteristicRepository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/characteristics_for_product")
    public Iterable<Characteristic> getCharacteristicsForProduct(@RequestParam(name = "productId") Integer productId) {
        return characteristicRepository.findCharacteristicByIdProd(productId).subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/customer_employee_suppliers")
    public Iterable<CustomerEmployeeSupplier> getAllCustomerEmployeeSupplier() {
        return customerEmployeeSupplierRepository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }
    @GetMapping("/employee")
    public Iterable<String> getEmployeeWithGreatestNrOfInvoices() {
        return customerEmployeeSupplierRepository.findEmployeeWithGreatestNrOfInvoices().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/ces_by_type")
    public Iterable<CustomerEmployeeSupplier> getCustomerEmployeeSupplierByTypeCES(@RequestParam(name = "type") char type) {
        return customerEmployeeSupplierRepository.findCustomerEmployeeSupplierByTypeCES(type).subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/invoices")
    public Iterable<Invoice> getAllInvoices() {
        return invoiceRepository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/max_invoice")
    public Float getMaxInvoice() {
        return invoiceRepository.findMaxValue().subscribeOn(Schedulers.parallel()).block();
    }

    @GetMapping("/month_with_greatest_sale")
    public Iterable<MonthSale> getMonthWithGreatestSale() {
        return invoiceRepository.getMonthWithGreatestSales().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/sales_cost")
    public List<SalesCostMonthYear> getSalesCost() {
        return invoiceRepository.findSalesCostMonthYear().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/profit_on_each_product")
    public List<ProfitOnEachProduct> getProfitOnEachProduct() {
        return invoiceRepository.findProfitOnEachProduct().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/items")
    public Iterable<Item> getAllItems() {
        return itemRepository.findAll().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

    @GetMapping("/items_between_dates")
    public Iterable<ProdQuantity1> getItemsBetweenDates() {
        return  itemRepository.findItemsBetweenDates().subscribeOn(Schedulers.parallel()).buffer().blockLast();
    }

}
