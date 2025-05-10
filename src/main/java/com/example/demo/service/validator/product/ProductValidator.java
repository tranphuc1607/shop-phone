package com.example.demo.service.validator.product;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.entity.Product;
import com.example.demo.entity.ProductSpecification;

import java.math.BigDecimal;
import java.util.Arrays;

@Component
public class ProductValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Product.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Product product = (Product) target;

        // Kiểm tra tên sản phẩm (Name) không trống và lớn hơn 3 ký tự
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            errors.rejectValue("name", "product.name.empty", "Vui lòng điền tên sản phẩm.");
        } else if (product.getName().length() < 3) {
            errors.rejectValue("name", "product.name.short", "Tên sản phẩm phải có ít nhất 3 ký tự.");
        }

        // Kiểm tra mô tả sản phẩm (Description) không trống và lớn hơn 3 ký tự
        if (product.getDescription() == null || product.getDescription().trim().isEmpty()) {
            errors.rejectValue("description", "product.description.empty", "Vui lòng điền mô tả sản phẩm.");
        } else if (product.getDescription().length() < 3) {
            errors.rejectValue("description", "product.description.short", "Mô tả sản phẩm phải có ít nhất 3 ký tự.");
        }

        // Kiểm tra giá sản phẩm (Price) không trống và phải lớn hơn 0
        if (product.getPrice() == null) {
            errors.rejectValue("price", "product.price.empty", "Vui lòng điền giá sản phẩm.");
        } else if (Double.parseDouble(product.getPrice()) <= 0) {
            errors.rejectValue("price", "product.price.invalid", "Giá sản phẩm phải lớn hơn 0.");
        }

        // Kiểm tra số lượng sản phẩm (Stock Quantity) không trống và không được âm
        if (product.getStockQuantity() == null) {
            errors.rejectValue("stockQuantity", "product.stockQuantity.empty", "Vui lòng điền số lượng sản phẩm.");
        } else if (Double.parseDouble(product.getStockQuantity()) <= 0) {
            errors.rejectValue("stockQuantity", "product.stockQuantity.invalid", "Số lượng sản phẩm không thể là số âm.");
        }

        // Kiểm tra có thương hiệu (Brand) không
        if (product.getBrand() == null || product.getBrand().getId() == null) {
            errors.rejectValue("brand.id", "product.brand.empty", "Vui lòng chọn thương hiệu sản phẩm.");
        }

        String image = product.getImage();
        System.out.println(image);
        if (image == null || image.isEmpty()) {
            errors.rejectValue("image", "product.image.empty", "Vui lòng tải lên ảnh sản phẩm.");
        }

        // Kiểm tra ProductSpecification (Chi tiết sản phẩm)
        ProductSpecification specification = product.getSpecification();
        if (specification != null) {
            // Kiểm tra RAM (Số) không trống và không nhỏ hơn 0
            if (specification.getRam() == null || specification.getRam().trim().isEmpty()) {
                errors.rejectValue("specification.ram", "productSpecification.ram.empty", "Vui lòng điền RAM.");
            } else {
                try {
                    BigDecimal ramValue = new BigDecimal(specification.getRam().trim());
                    if (ramValue.compareTo(BigDecimal.ZERO) < 0) {
                        errors.rejectValue("specification.ram", "productSpecification.ram.invalid", "RAM không thể là số âm.");
                    }
                } catch (NumberFormatException e) {
                    errors.rejectValue("specification.ram", "productSpecification.ram.invalid", "RAM phải là một số hợp lệ.");
                }
            }

            // Kiểm tra Storage (Số) không trống và không nhỏ hơn 0
            if (specification.getStorage() == null || specification.getStorage().trim().isEmpty()) {
                errors.rejectValue("specification.storage", "productSpecification.storage.empty", "Vui lòng điền bộ nhớ.");
            } else {
                try {
                    BigDecimal storageValue = new BigDecimal(specification.getStorage().trim());
                    if (storageValue.compareTo(BigDecimal.ZERO) < 0) {
                        errors.rejectValue("specification.storage", "productSpecification.storage.invalid", "Bộ nhớ không thể là số âm.");
                    }
                } catch (NumberFormatException e) {
                    errors.rejectValue("specification.storage", "productSpecification.storage.invalid", "Bộ nhớ phải là một số hợp lệ.");
                }
            }

            // Kiểm tra Screen (Số) không trống và không nhỏ hơn 0
            if (specification.getScreen() == null || specification.getScreen().trim().isEmpty()) {
                errors.rejectValue("specification.screen", "productSpecification.screen.empty", "Vui lòng điền kích thước màn hình.");
            } else {
                try {
                    BigDecimal screenValue = new BigDecimal(specification.getScreen().trim());
                    if (screenValue.compareTo(BigDecimal.ZERO) < 0) {
                        errors.rejectValue("specification.screen", "productSpecification.screen.invalid", "Kích thước màn hình không thể là số âm.");
                    }
                } catch (NumberFormatException e) {
                    errors.rejectValue("specification.screen", "productSpecification.screen.invalid", "Kích thước màn hình phải là một số hợp lệ.");
                }
            }

            // Kiểm tra Battery (Số) không trống và không nhỏ hơn 0
            if (specification.getBattery() == null || specification.getBattery().trim().isEmpty()) {
                errors.rejectValue("specification.battery", "productSpecification.battery.empty", "Vui lòng điền dung lượng pin.");
            } else {
                try {
                    BigDecimal batteryValue = new BigDecimal(specification.getBattery().trim());
                    if (batteryValue.compareTo(BigDecimal.ZERO) < 0) {
                        errors.rejectValue("specification.battery", "productSpecification.battery.invalid", "Dung lượng pin không thể là số âm.");
                    }
                } catch (NumberFormatException e) {
                    errors.rejectValue("specification.battery", "productSpecification.battery.invalid", "Dung lượng pin phải là một số hợp lệ.");
                }
            }

            // Kiểm tra OS (Hệ điều hành) phải có ít nhất 3 ký tự
            String[] validOs = {"ANDROID", "IOS", "WINDOWS", "LINUX"};
            String os = specification.getOs();
            if (os == null || os.trim().isEmpty()) {
                errors.rejectValue("specification.os", "productSpecification.os.empty", "Vui lòng điền hệ điều hành.");
            } else if (os.length() < 3) {
                errors.rejectValue("specification.os", "productSpecification.os.short", "Hệ điều hành phải có ít nhất 3 ký tự.");
            } else if (Arrays.stream(validOs).noneMatch(valid -> valid.equalsIgnoreCase(os))) {
                errors.rejectValue("specification.os", "productSpecification.os.invalid", "Hệ điều hành không hợp lệ.");
            }

            // Kiểm tra Chipset (Chipset) phải có ít nhất 3 ký tự
            String[] validChipsets = {"Qualcomm", "Exynos", "Apple A", "MediaTek"};
            String chipset = specification.getChipset();
            if (chipset == null || chipset.trim().isEmpty()) {
                errors.rejectValue("specification.chipset", "productSpecification.chipset.empty", "Vui lòng điền chipset.");
            } else if (chipset.length() < 3) {
                errors.rejectValue("specification.chipset", "productSpecification.chipset.short", "Chipset phải có ít nhất 3 ký tự.");
            } else if (Arrays.stream(validChipsets).noneMatch(valid -> valid.equalsIgnoreCase(chipset))) {
                errors.rejectValue("specification.chipset", "productSpecification.chipset.invalid", "Chipset không hợp lệ.");
            }
        }
    }
}

