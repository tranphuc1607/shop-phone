package com.example.demo.controller.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.entity.Product;
import com.example.demo.entity.ProductImage;
import com.example.demo.service.ProductService;

import org.springframework.ui.Model;


@Controller
public class ProductController {
    private final ProductService productService;

    public ProductController (ProductService productService) {
        this.productService =productService;
    }
    @GetMapping("admin/product")
    public String getProduct() {
        return "/admin/product/showInterface";
    }
      @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) throws SQLException {
        model.addAttribute("listBrand",this.productService.getListBrand());
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }
    @PostMapping("/admin/product/create")
public String createProduct(@ModelAttribute Product newProduct,
                            @RequestParam("images") MultipartFile[] images,
                            @RequestParam("primaryImageIndex") int primaryIndex) throws IOException {

    // Chuyển đổi MultipartFile[] thành List<ProductImage>
    List<ProductImage> productImages = new ArrayList<>();
    for (int i = 0; i < images.length; i++) {
        ProductImage productImage = new ProductImage();
        productImage.setUrl(images[i].getOriginalFilename());  // Bạn có thể lưu URL hoặc lưu tệp sau khi upload.
        productImage.setIsPrimary(i == primaryIndex);  // Đánh dấu ảnh chính.
        productImages.add(productImage);
    }

    newProduct.setImages(productImages);  // Gán danh sách ảnh vào product.

    // Gọi service để xử lý logic tạo sản phẩm
    this.productService.createProduct(newProduct, images, primaryIndex);

    // Sau khi tạo xong, chuyển hướng về trang danh sách sản phẩm
    return "redirect:/admin/products";
}
    
}
