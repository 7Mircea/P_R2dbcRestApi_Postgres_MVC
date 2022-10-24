package com.example.r2dbc_mvc.model.custom_query_return;

import lombok.Data;
import lombok.Value;

@Data
public class CategoryProductProfit {
        String category;
        String product_name;
        float profit;
}
