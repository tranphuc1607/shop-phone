// package com.example.demo.config;

// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.security.config.annotation.web.builders.HttpSecurity;
// import org.springframework.security.web.SecurityFilterChain;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
// import org.springframework.security.crypto.password.PasswordEncoder;

// @Configuration
// public class SecurityConfig {

//     @Bean
//     public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//         http
//             .authorizeHttpRequests(authorize -> authorize
//                 .requestMatchers("/admin/**").hasRole("ADMIN")   // Chặn URL /admin phải ADMIN mới vào
//                 .anyRequest().permitAll()                       // Các URL khác thì ai cũng truy cập được
//             )
//             .formLogin(form -> form
//                 .loginPage("/login")          // Trang login custom
//                 .defaultSuccessUrl("/")        // Login thành công về trang chủ
//                 .permitAll()
//             )
//             .logout(logout -> logout
//                 .logoutUrl("/logout")
//                 .logoutSuccessUrl("/login?logout")
//                 .permitAll()
//             )
//             .csrf(csrf -> csrf.disable()); // Disable CSRF nếu đang phát triển (sản phẩm thật nên bật lại)

//         return http.build();
//     }

//     @Bean
//     public PasswordEncoder passwordEncoder() {
//         return new BCryptPasswordEncoder();
//     }
// }
