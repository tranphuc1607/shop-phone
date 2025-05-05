package com.example.demo.service.validator.user.Valid;


import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

import com.example.demo.service.validator.user.Validator.ValidEmailValidator;

@Documented
@Constraint(validatedBy = ValidEmailValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidEmailUser {
    String message() default "Email không hợp lệ";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
