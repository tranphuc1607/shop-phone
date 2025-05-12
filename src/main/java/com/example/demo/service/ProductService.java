package com.example.demo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.entity.Brand;
import com.example.demo.entity.Product;
import com.example.demo.entity.ProductSpecification;
import com.example.demo.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

   public  ProductService (ProductRepository productRepository) {
        this.productRepository = productRepository;
   }
    public List<Brand> getListBrand() throws SQLException {
        return this.productRepository.getAllBrands();
    }

    public List<Product> getListProduct() throws SQLException {
        return this.productRepository.getAllProducts();
    }

    public Product getProductById(int id) throws SQLException {
        return this.productRepository.findProductById(id);
    }

    public void handleSaveProduct(Product product) throws SQLException {
        this.productRepository.saveProduct(product);
    }
    
    
}
