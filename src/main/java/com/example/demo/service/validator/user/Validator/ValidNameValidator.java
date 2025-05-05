package com.example.demo.service.validator.user.Validator;

import com.example.demo.service.validator.user.Valid.ValidNameUser.ValidName;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class ValidNameValidator implements ConstraintValidator<ValidName, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null || value.trim().isEmpty()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Vui lòng nhập tên của bạn")
                   .addConstraintViolation();
            return false;
        }

        if (value.length() < 3) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Tên phải có tối thiểu 3 kí tự")
                   .addConstraintViolation();
            return false;
        }

        return true;
    }
    }

