package com.example.demo.controller.client;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.demo.entity.Product;
import com.example.demo.service.ProductService;

@Controller
public class ProductControler {

    @Autowired
    private ProductService productService;
    @GetMapping("/product")
    public String getProduct(Model model) throws SQLException {
        List<Product> products = this.productService.getListProduct();
        model.addAttribute("products", products);
        return "client/product/interface";
    }

     @PostMapping("/product/addToCart/{id}")
     public String getProductDetail(@PathVariable("id") int id, Model model) {
        try {
            Product product = productService.getProductById(id);
            if (product == null) {
                model.addAttribute("error", "Không tìm thấy sản phẩm");
            }
            model.addAttribute("product", product);
            //System.out.println("Product: " + product.getImage());
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi lấy thông tin sản phẩm: " + e.getMessage());
            return "client/detailProduct/detailProduct";
        }
        
        return "client/detailProduct/addToCart";
     }
}
