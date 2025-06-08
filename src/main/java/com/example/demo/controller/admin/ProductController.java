package com.example.demo.controller.admin;

//import java.io.File;
//import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.entity.Product;
import com.example.demo.service.ProductService;
import com.example.demo.service.UploadFileService;
import com.example.demo.service.validator.product.ProductValidator;

import jakarta.validation.Valid;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;


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
    // @GetMapping("/admin/product")
    // public String getProduct(Model model) throws SQLException {
    //     List<Product> listProduct = this.productService.getListProduct();
    //     model.addAttribute("products",listProduct);
    //     return "admin/product/showInterface";
    // }
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
        Product product = this.productService.getProductById(id);
        model.addAttribute("updateProduct", product);
        model.addAttribute("listBrand", this.productService.getListBrand());
        return "admin/product/update";
    }

   @PostMapping("/admin/product/update/{id}")
public String updateProduct(
        @PathVariable("id") int id,
        @ModelAttribute("updateProduct") @Valid Product updateProduct,
        BindingResult updateProductBindingResult,
        @RequestParam("productFile") MultipartFile file,
        Model model
) throws SQLException {

    if (!file.isEmpty()) {
        String imageName = uploadFileService.handleSaveUploadFile(file);
        updateProduct.setImage(imageName);
    }

    productValidator.validate(updateProduct, updateProductBindingResult);

    if (updateProductBindingResult.hasErrors()) {
        // Gán lại ID nếu cần
        updateProduct.setId(id);
        model.addAttribute("listBrand", this.productService.getListBrand());
        return "admin/product/update"; // Không redirect!
    }

    updateProduct.setId(id); // Gán ID vào product nếu bị mất
    productService.handleUpdateProduct(updateProduct);

    return "redirect:/admin/product";
}

 @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductProductPage(RedirectAttributes redirectAttributes, @PathVariable int id) throws SQLException {
        this.productService.deleteProduct(id);
	    redirectAttributes.addFlashAttribute("success", "Xóa thành công!");
	    return "redirect:/admin/product";
    }

      @GetMapping("/admin/product")
    public String listProducts(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "4") int size,
            Model model) {

        List<Product> products = this.productService.getProductsByPage(page, size);
        System.out.println(products);
        long totalProducts = this.productService.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);

       return "admin/product/showInterface";
    }

}
