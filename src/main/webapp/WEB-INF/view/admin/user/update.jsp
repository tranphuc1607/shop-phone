<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Cập nhật người dùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        
        .input-group {
            position: relative;
            transition: all 0.3s ease;
        }
        
        .input-group:hover {
            transform: translateY(-2px);
        }
        
        .form-input {
            transition: all 0.3s ease;
            border: 2px solid #e2e8f0;
        }
        
        .form-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: scale(1.02);
        }
        
        .form-input:disabled {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-color: #cbd5e1;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(100, 116, 139, 0.4);
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(100, 116, 139, 0.6);
        }
        
        .floating-label {
            transition: all 0.3s ease;
        }
        
        .icon-wrapper {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 10;
        }
        
        .input-with-icon {
            padding-left: 45px;
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .slide-in {
            animation: slideIn 0.6s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-row {
            animation: slideIn 0.6s ease-out;
        }
        
        .form-row:nth-child(1) { animation-delay: 0.1s; }
        .form-row:nth-child(2) { animation-delay: 0.2s; }
        .form-row:nth-child(3) { animation-delay: 0.3s; }
        .form-row:nth-child(4) { animation-delay: 0.4s; }
        .form-row:nth-child(5) { animation-delay: 0.5s; }
        
        .success-indicator {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #10b981;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .form-input:valid + .success-indicator {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="min-h-screen py-12 px-4">
        <div class="max-w-lg mx-auto">
            <!-- Header Section -->
            <div class="text-center mb-8 slide-in">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-full shadow-lg mb-4">
                    <i class="fas fa-user-edit text-2xl text-indigo-600"></i>
                </div>
                <h1 class="text-3xl font-bold text-white mb-2">Cập nhật thông tin</h1>
                <p class="text-indigo-100">Chỉnh sửa thông tin người dùng của bạn</p>
            </div>

            <!-- Form Container -->
            <div class="glass-card rounded-2xl p-8 slide-in">
                <form:form action="/admin/user/update" method="post" modelAttribute="currentUser" cssClass="space-y-6">
                    <form:hidden path="id"/>

                    <!-- Email Field (Disabled) -->
                    <div class="input-group form-row opacity-0">
                        <label class="block text-sm font-semibold text-gray-700 mb-2 floating-label">
                            <i class="fas fa-envelope mr-2 text-indigo-500"></i>Email
                        </label>
                        <div class="relative">
                            <div class="icon-wrapper">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <form:input path="email" 
                                cssClass="form-input w-full input-with-icon py-3 px-4 rounded-xl bg-gray-50 text-gray-600 font-medium" 
                                disabled="true" 
                                placeholder="Email không thể thay đổi"/>
                            <div class="absolute right-3 top-3 text-gray-400">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500 mt-1 ml-1">
                            <i class="fas fa-info-circle mr-1"></i>Email không thể được thay đổi
                        </p>
                    </div>

                    <!-- Full Name Field -->
                    <div class="input-group form-row opacity-0">
                        <label class="block text-sm font-semibold text-gray-700 mb-2 floating-label">
                            <i class="fas fa-user mr-2 text-indigo-500"></i>Tên đầy đủ
                        </label>
                        <div class="relative">
                            <div class="icon-wrapper">
                                <i class="fas fa-user"></i>
                            </div>
                            <form:input path="name" 
                                cssClass="form-input w-full input-with-icon py-3 px-4 rounded-xl border-2 font-medium" 
                                placeholder="Nhập tên đầy đủ của bạn"
                                required="true"/>
                            <div class="success-indicator">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Address Field -->
                    <div class="input-group form-row opacity-0">
                        <label class="block text-sm font-semibold text-gray-700 mb-2 floating-label">
                            <i class="fas fa-map-marker-alt mr-2 text-indigo-500"></i>Địa chỉ
                        </label>
                        <div class="relative">
                            <div class="icon-wrapper">
                                <i class="fas fa-home"></i>
                            </div>
                            <form:input path="address" 
                                cssClass="form-input w-full input-with-icon py-3 px-4 rounded-xl border-2 font-medium" 
                                placeholder="Nhập địa chỉ của bạn"/>
                            <div class="success-indicator">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Phone Field -->
                    <div class="input-group form-row opacity-0">
                        <label class="block text-sm font-semibold text-gray-700 mb-2 floating-label">
                            <i class="fas fa-phone mr-2 text-indigo-500"></i>Số điện thoại
                        </label>
                        <div class="relative">
                            <div class="icon-wrapper">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <form:input path="phone" 
                                cssClass="form-input w-full input-with-icon py-3 px-4 rounded-xl border-2 font-medium" 
                                placeholder="Nhập số điện thoại"
                                pattern="[0-9]{10,11}"
                                title="Vui lòng nhập số điện thoại hợp lệ (10-11 số)"/>
                            <div class="success-indicator">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-col sm:flex-row gap-4 pt-6 form-row opacity-0">
                        <button type="submit" 
                            class="btn-primary flex-1 text-white font-semibold py-3 px-6 rounded-xl inline-flex items-center justify-center">
                            <i class="fas fa-save mr-2"></i>
                            Cập nhật thông tin
                        </button>
                        <a href="/admin/user" 
                            class="btn-secondary flex-1 text-white font-semibold py-3 px-6 rounded-xl inline-flex items-center justify-center text-center">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Quay lại
                        </a>
                    </div>
                </form:form>

                <!-- Success Message Placeholder -->
                <div id="successMessage" class="hidden mt-4 p-4 bg-green-50 border border-green-200 rounded-xl">
                    <div class="flex items-center">
                        <i class="fas fa-check-circle text-green-500 mr-3"></i>
                        <span class="text-green-800 font-medium">Thông tin đã được cập nhật thành công!</span>
                    </div>
                </div>
            </div>

            <!-- Help Section -->
            <div class="mt-8 text-center slide-in">
                <div class="inline-flex items-center px-4 py-2 bg-white bg-opacity-20 rounded-full text-white text-sm">
                    <i class="fas fa-shield-alt mr-2"></i>
                    Thông tin của bạn được bảo mật an toàn
                </div>
            </div>
        </div>
    </div>

    <script>
        // Animation for form elements
        document.addEventListener('DOMContentLoaded', function() {
            const formRows = document.querySelectorAll('.form-row');
            
            formRows.forEach((row, index) => {
                setTimeout(() => {
                    row.style.opacity = '1';
                }, index * 100);
            });

            // Add focus animations
            const inputs = document.querySelectorAll('.form-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });

            // Form validation feedback
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const submitBtn = form.querySelector('button[type="submit"]');
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang cập nhật...';
                    submitBtn.disabled = true;
                });
            }

            // Phone number formatting
            const phoneInput = document.querySelector('input[name="phone"]');
            if (phoneInput) {
                phoneInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length > 11) value = value.slice(0, 11);
                    e.target.value = value;
                });
            }
        });
    </script>
</body>
</html>