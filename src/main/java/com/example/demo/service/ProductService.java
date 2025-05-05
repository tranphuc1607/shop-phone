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
import com.example.demo.entity.ProductImage;
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

    private String uploadImage(MultipartFile image) throws IOException {
        // Đảm bảo rằng thư mục đã tồn tại
        String uploadDir = "uploads/images/";
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    
        // Lưu tệp vào thư mục
        String fileName = System.currentTimeMillis() + "-" + image.getOriginalFilename();
        Path path = Paths.get(uploadDir + fileName);
        Files.write(path, image.getBytes());
    
        return fileName; // Trả về tên tệp hoặc URL nếu bạn lưu tệp trên dịch vụ bên ngoài
    }
    


    public void createProduct(Product newProduct, MultipartFile[] images, int primaryIndex) throws IOException {
        // Chuyển đổi MultipartFile[] thành ProductImage
        List<ProductImage> productImages = new ArrayList<>();
        for (int i = 0; i < images.length; i++) {
            ProductImage productImage = new ProductImage();
            productImage.setUrl(uploadImage(images[i])); // Giả sử bạn có phương thức uploadImage() để lưu ảnh.
            productImage.setIsPrimary(i == primaryIndex);
            productImages.add(productImage);
        }
    
        newProduct.setImages(productImages);
        // Lưu product vào cơ sở dữ liệu
        this.productRepository.save(newProduct);
    }
    
    
}
