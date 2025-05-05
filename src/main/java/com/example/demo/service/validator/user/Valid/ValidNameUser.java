package com.example.demo.service.validator.user.Valid;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.example.demo.service.validator.user.Validator.ValidNameValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

public class ValidNameUser {
    @Documented
    @Constraint(validatedBy = ValidNameValidator.class)
    @Target({ ElementType.FIELD })
    @Retention(RetentionPolicy.RUNTIME)
    public @interface ValidName {
        String message() default "Tên không hợp lệ";
        Class<?>[] groups() default {};
        Class<? extends Payload>[] payload() default {};
    }
}
