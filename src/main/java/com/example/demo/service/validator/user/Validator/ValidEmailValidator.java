package com.example.demo.service.validator.user.Validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.demo.repository.UserRepository;
import com.example.demo.service.validator.user.Valid.ValidEmailUser;

import java.util.regex.Pattern;

public class ValidEmailValidator implements ConstraintValidator<ValidEmailUser, String> {
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    @Autowired
    private UserRepository userRepository; // Inject UserRepository

    @Override
    public boolean isValid(String email, ConstraintValidatorContext context) {
        if (email == null || email.trim().isEmpty()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Vui lòng nhập email")
                   .addConstraintViolation();
            return false;
        }

        // Kiểm tra định dạng email
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Email không đúng định dạng")
                   .addConstraintViolation();
            return false;
        }

        // Kiểm tra email đã tồn tại trong database
        if (userRepository.existsByEmail(email)) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Email đã được sử dụng")
                   .addConstraintViolation();
            return false;
        }

        return true;
    }
}
