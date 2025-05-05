package com.example.demo.service.validator.user.Valid;


import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

import com.example.demo.service.validator.user.Validator.ValidPasswordValidator;

@Documented
@Constraint(validatedBy = ValidPasswordValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidPasswordUser {
    String message() default "Mật khẩu không hợp lệ";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
