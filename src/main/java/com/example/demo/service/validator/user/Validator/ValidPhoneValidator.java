package com.example.demo.service.validator.user.Validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.util.regex.Pattern;

import com.example.demo.service.validator.user.Valid.ValidPhoneUser.ValidPhone;

public class ValidPhoneValidator implements ConstraintValidator<ValidPhone, String> {

    private static final String PHONE_REGEX = "^(0[3|5|7|8|9])([0-9]{8})$";
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    @Override
public boolean isValid(String phone, ConstraintValidatorContext context) {
    // Nếu rỗng hoặc null, chỉ cần thông báo "Vui lòng nhập số điện thoại của bạn"
    if (phone == null || phone.trim().isEmpty()) {
        context.disableDefaultConstraintViolation();  // Vô hiệu hóa thông báo mặc định
        context.buildConstraintViolationWithTemplate("Vui lòng nhập số điện thoại của bạn")
               .addConstraintViolation();  // Tạo thông báo lỗi tùy chỉnh
        return false; // Không hợp lệ nếu chưa nhập
    }

    // Nếu đã nhập, kiểm tra định dạng số điện thoại
    if (!PHONE_PATTERN.matcher(phone).matches()) {
        context.disableDefaultConstraintViolation();  // Vô hiệu hóa thông báo mặc định
        context.buildConstraintViolationWithTemplate("Số điện thoại không đúng định dạng")
               .addConstraintViolation();  // Tạo thông báo lỗi tùy chỉnh
        return false; // Không hợp lệ nếu sai định dạng
    }

    return true;
}

}
