<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo mới người dùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-gray-100">
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />
     <jsp:include page="../layout/navbar.jsp" />
    <div class="flex min-h-screen pt-16">
        <!-- Sidebar/Navbar -->
       
        
        <!-- Main Content Area -->
        <div class="flex-1 ml-64">
            <main class="p-6">
                <!-- Page Header -->
                <div class="mb-8">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-900">Tạo mới người dùng</h1>
                            <nav class="text-sm mt-2">
                                <ol class="flex items-center space-x-2 text-gray-600">
                                    <li>
                                        <a href="/admin/dashboard" class="hover:text-blue-600 transition">
                                            <i class="fas fa-home mr-1"></i>Tổng quan
                                        </a>
                                    </li>
                                    <li><i class="fas fa-chevron-right text-gray-400"></i></li>
                                    <li>
                                        <a href="/admin/user" class="hover:text-blue-600 transition">
                                            <i class="fas fa-users mr-1"></i>Người dùng
                                        </a>
                                    </li>
                                    <li><i class="fas fa-chevron-right text-gray-400"></i></li>
                                    <li class="text-gray-900 font-medium">Tạo mới</li>
                                </ol>
                            </nav>
                        </div>
                        <a href="/admin/user" 
                           class="inline-flex items-center px-4 py-2 bg-gray-500 hover:bg-gray-600 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </div>

                <!-- Form Card -->
                <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                    <!-- Card Header -->
                    <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
                        <div class="flex items-center">
                            <div class="bg-white bg-opacity-20 rounded-full p-3 mr-4">
                                <i class="fas fa-user-plus text-white text-xl"></i>
                            </div>
                            <div>
                                <h2 class="text-xl font-semibold text-white">Thông tin người dùng mới</h2>
                                <p class="text-blue-100 text-sm">Vui lòng điền đầy đủ thông tin bên dưới</p>
                            </div>
                        </div>
                    </div>

                    <!-- Form Body -->
                    <div class="p-8">
                        <form:form method="post" action="/admin/user/create" modelAttribute="newUser" 
                                   class="space-y-6" enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <!-- Basic Information Section -->
                            <div>
                                <h3 class="text-lg font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200">
                                    <i class="fas fa-info-circle text-blue-600 mr-2"></i>
                                    Thông tin cơ bản
                                </h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Name Field -->
                                    <div class="flex flex-col">
                                        <c:set var="errorName">
                                            <form:errors path="name" />
                                        </c:set>
                                        <label for="name" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-user mr-1 text-gray-500"></i>
                                            Họ và tên <span class="text-red-500">*</span>
                                        </label>
                                        <form:input type="text" id="name"
                                            class="border rounded-lg p-3 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition ${not empty errorName ? 'border-red-500 bg-red-50' : 'border-gray-300'}"
                                            path="name" placeholder="Nhập họ và tên đầy đủ" />
                                        <form:errors path="name" cssClass="text-red-500 text-xs mt-1 flex items-center">
                                            <i class="fas fa-exclamation-circle mr-1"></i>
                                        </form:errors>
                                    </div>

                                    <!-- Email Field -->
                                    <div class="flex flex-col">
                                        <c:set var="errorEmail">
                                            <form:errors path="email" />
                                        </c:set>
                                        <label for="email" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-envelope mr-1 text-gray-500"></i>
                                            Email <span class="text-red-500">*</span>
                                        </label>
                                        <form:input type="email" id="email"
                                            class="border rounded-lg p-3 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition ${not empty errorEmail ? 'border-red-500 bg-red-50' : 'border-gray-300'}" 
                                            path="email" placeholder="example@email.com" />
                                        <form:errors path="email" cssClass="text-red-500 text-xs mt-1 flex items-center">
                                            <i class="fas fa-exclamation-circle mr-1"></i>
                                        </form:errors>
                                    </div>
                                </div>
                            </div>

                            <!-- Security Section -->
                            <div>
                                <h3 class="text-lg font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200">
                                    <i class="fas fa-shield-alt text-green-600 mr-2"></i>
                                    Bảo mật và quyền hạn
                                </h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Password Field -->
                                    <div class="flex flex-col">
                                        <c:set var="errorPassword">
                                            <form:errors path="password" />
                                        </c:set>
                                        <label for="password" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-lock mr-1 text-gray-500"></i>
                                            Mật khẩu <span class="text-red-500">*</span>
                                        </label>
                                        <div class="relative">
                                            <form:input type="password" id="password"
                                                class="border rounded-lg p-3 pr-10 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition ${not empty errorPassword ? 'border-red-500 bg-red-50' : 'border-gray-300'}"
                                                path="password" placeholder="Nhập mật khẩu" />
                                            <button type="button" class="absolute inset-y-0 right-0 pr-3 flex items-center" onclick="togglePassword()">
                                                <i class="fas fa-eye text-gray-400 hover:text-gray-600" id="togglePasswordIcon"></i>
                                            </button>
                                        </div>
                                        <form:errors path="password" cssClass="text-red-500 text-xs mt-1 flex items-center">
                                            <i class="fas fa-exclamation-circle mr-1"></i>
                                        </form:errors>
                                        <p class="text-xs text-gray-500 mt-1">Mật khẩu phải có ít nhất 6 ký tự</p>
                                    </div>

                                    <!-- Role Field -->
                                    <div class="flex flex-col">
                                        <label for="role" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-user-tag mr-1 text-gray-500"></i>
                                            Vai trò <span class="text-red-500">*</span>
                                        </label>
                                        <form:select id="role" path="role" 
                                            class="border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition">
                                            <form:option value="">-- Chọn vai trò --</form:option>
                                            <form:option value="ADMIN">
                                                👑 Quản trị viên (Toàn quyền)
                                            </form:option>
                                            <form:option value="USER">
                                                👤 Người dùng (Quyền hạn cơ bản)
                                            </form:option>
                                        </form:select>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Information Section -->
                            <div>
                                <h3 class="text-lg font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200">
                                    <i class="fas fa-address-book text-purple-600 mr-2"></i>
                                    Thông tin liên hệ
                                </h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Phone Field -->
                                    <div class="flex flex-col">
                                        <c:set var="errorPhone">
                                            <form:errors path="phone" />
                                        </c:set>
                                        <label for="phone" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-phone mr-1 text-gray-500"></i>
                                            Số điện thoại
                                        </label>
                                        <form:input type="text" id="phone" 
                                            class="border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition" 
                                            path="phone" placeholder="0123456789" />
                                        <form:errors path="phone" cssClass="text-red-500 text-xs mt-1 flex items-center">
                                            <i class="fas fa-exclamation-circle mr-1"></i>
                                        </form:errors>
                                    </div>

                                    <!-- Empty space for layout balance -->
                                    <div class="hidden md:block"></div>

                                    <!-- Address Field (Full width) -->
                                    <div class="flex flex-col md:col-span-2">
                                        <label for="address" class="text-sm font-medium mb-2 text-gray-700">
                                            <i class="fas fa-map-marker-alt mr-1 text-gray-500"></i>
                                            Địa chỉ
                                        </label>
                                        <form:textarea id="address" rows="3"
                                            class="border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition resize-none" 
                                            path="address" placeholder="Nhập địa chỉ đầy đủ (số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)" />
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="pt-6 border-t border-gray-200">
                                <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                                    <button type="submit"
                                        class="w-full sm:w-auto px-8 py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg transform hover:-translate-y-0.5">
                                        <i class="fas fa-user-plus mr-2"></i>
                                        Tạo người dùng
                                    </button>
                                    <a href="/admin/user" 
                                       class="w-full sm:w-auto px-8 py-3 bg-gray-500 hover:bg-gray-600 text-white font-medium rounded-lg text-center transition duration-200 shadow-md hover:shadow-lg">
                                        <i class="fas fa-times mr-2"></i>
                                        Hủy bỏ
                                    </a>
                                </div>
                                <p class="text-center text-xs text-gray-500 mt-4">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    Các trường có dấu <span class="text-red-500">*</span> là bắt buộc
                                </p>
                            </div>
                        </form:form>
                    </div>
                </div>

                <!-- Help Section -->
                <div class="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
                    <div class="flex items-start">
                        <i class="fas fa-lightbulb text-blue-600 text-lg mr-3 mt-1"></i>
                        <div>
                            <h4 class="text-sm font-semibold text-blue-800 mb-2">Gợi ý tạo tài khoản</h4>
                            <ul class="text-xs text-blue-700 space-y-1">
                                <li>• Sử dụng email thật để người dùng có thể nhận thông báo</li>
                                <li>• Mật khẩu nên chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số</li>
                                <li>• Chỉ cấp quyền Admin cho những người cần thiết</li>
                                <li>• Số điện thoại giúp liên hệ nhanh chóng khi cần thiết</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('togglePasswordIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        // Form validation
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const submitButton = form.querySelector('button[type="submit"]');
            
            form.addEventListener('submit', function() {
                submitButton.disabled = true;
                submitButton.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang tạo...';
            });

            // Real-time validation
            const requiredFields = ['name', 'email', 'password', 'role'];
            requiredFields.forEach(fieldName => {
                const field = document.getElementById(fieldName);
                if (field) {
                    field.addEventListener('blur', function() {
                        validateField(this);
                    });
                }
            });
        });

        function validateField(field) {
            const value = field.value.trim();
            const fieldName = field.name;
            
            // Remove existing validation messages
            const existingError = field.parentElement.querySelector('.validation-error');
            if (existingError) {
                existingError.remove();
            }
            
            let isValid = true;
            let errorMessage = '';
            
            switch(fieldName) {
                case 'email':
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (value && !emailRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Email không hợp lệ';
                    }
                    break;
                case 'password':
                    if (value && value.length < 6) {
                        isValid = false;
                        errorMessage = 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    break;
                case 'phone':
                    const phoneRegex = /^[0-9]{10,11}$/;
                    if (value && !phoneRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Số điện thoại không hợp lệ';
                    }
                    break;
            }
            
            if (!isValid) {
                const errorElement = document.createElement('div');
                errorElement.className = 'validation-error text-red-500 text-xs mt-1 flex items-center';
                errorElement.innerHTML = `<i class="fas fa-exclamation-circle mr-1"></i>${errorMessage}`;
                field.parentElement.appendChild(errorElement);
                
                field.classList.add('border-red-500', 'bg-red-50');
                field.classList.remove('border-gray-300');
            } else {
                field.classList.remove('border-red-500', 'bg-red-50');
                field.classList.add('border-gray-300');
            }
        }
    </script>
</body>

</html>