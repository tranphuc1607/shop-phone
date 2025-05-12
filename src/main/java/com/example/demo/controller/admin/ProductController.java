package com.example.demo.controller.admin;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.entity.Product;
import com.example.demo.service.ProductService;
import com.example.demo.service.UploadFileService;
import com.example.demo.service.validator.product.ProductValidator;

import jakarta.validation.Valid;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;


@Controller
public class ProductController {
    private final ProductService productService;
    private final UploadFileService uploadFileService;
    private final ProductValidator productValidator;

    public ProductController (ProductService productService,UploadFileService uploadFileService,ProductValidator productValidator) {
        this.productService =productService;
        this.uploadFileService = uploadFileService;
        this.productValidator = productValidator;
    }
    @GetMapping("/admin/product")
    public String getProduct(Model model) throws SQLException {
        List<Product> listProduct = this.productService.getListProduct();
        model.addAttribute("products",listProduct);
        return "admin/product/showInterface";
    }
      @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) throws SQLException {
        model.addAttribute("listBrand",this.productService.getListBrand());
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }
    @PostMapping("/admin/product/create")
    public String createProduct(Model model, @ModelAttribute(name = "newProduct") @Valid Product newProduct,
            BindingResult newProductBindingResult, @RequestParam("productFile") MultipartFile file) throws SQLException {
                if (!file.isEmpty()) {
                    newProduct.setImage("duma.png");
                }
                productValidator.validate(newProduct, newProductBindingResult);
        if (newProductBindingResult.hasErrors()) {
            model.addAttribute("listBrand",this.productService.getListBrand());
            return "admin/product/create";
        } else {
            String productImg = this.uploadFileService.handleSaveUploadFile(file);
            newProduct.setImage(productImg);
             LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedNow = now.format(formatter);
            newProduct.setCreatedAt(formattedNow);
            this.productService.handleSaveProduct(newProduct);
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getDetailProduct(Model model, @PathVariable("id") int id) throws SQLException {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("id", id);
        return "admin/product/detail";

    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProduct(Model model, @PathVariable("id") int id) throws SQLException {
        model.addAttribute("updateProduct", new Product());
        model.addAttribute("listBrand", this.productService.getListBrand());
        return "admin/product/update";
    }
    
    }
