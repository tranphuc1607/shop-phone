package com.example.demo.service.validator.user.Validator;

import com.example.demo.service.validator.user.Valid.ValidPasswordUser;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class ValidPasswordValidator implements ConstraintValidator<ValidPasswordUser, String> {

    @Override
    public boolean isValid(String password, ConstraintValidatorContext context) {
        if (password == null || password.trim().isEmpty()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Vui lòng nhập mật khẩu")
                   .addConstraintViolation();
            return false;
        }

        if (password.length() < 6) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Mật khẩu phải có ít nhất 6 ký tự")
                   .addConstraintViolation();
            return false;
        }

        return true;
    }
}
