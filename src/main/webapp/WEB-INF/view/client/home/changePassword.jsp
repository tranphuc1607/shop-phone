<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow: hidden;
        }
        
        .gradient-bg::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) translateX(0px); }
            25% { transform: translateY(-10px) translateX(5px); }
            50% { transform: translateY(0px) translateX(-5px); }
            75% { transform: translateY(10px) translateX(5px); }
        }
        
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1);
        }
        
        .input-group {
            position: relative;
        }
        
        .input-field {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .input-field:focus {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(79, 70, 229, 0.15);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-primary:hover::before {
            left: 100%;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(79, 70, 229, 0.3);
        }
        
        .error-message {
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .floating-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.1);
            animation: floatIcons 15s ease-in-out infinite;
        }
        
        @keyframes floatIcons {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            25% { transform: translateY(-20px) rotate(90deg); }
            50% { transform: translateY(0px) rotate(180deg); }
            75% { transform: translateY(20px) rotate(270deg); }
        }
        
        .password-strength {
            height: 4px;
            background: #e5e7eb;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 8px;
        }
        
        .strength-bar {
            height: 100%;
            border-radius: 2px;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="min-h-screen gradient-bg flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative">
        <!-- Floating Background Icons -->
        <i class="fas fa-shield-alt floating-icon text-6xl" style="top: 10%; left: 10%;"></i>
        <i class="fas fa-lock floating-icon text-4xl" style="top: 20%; right: 15%; animation-delay: -5s;"></i>
        <i class="fas fa-key floating-icon text-5xl" style="bottom: 20%; left: 20%; animation-delay: -10s;"></i>
        <i class="fas fa-user-shield floating-icon text-4xl" style="bottom: 15%; right: 10%; animation-delay: -7s;"></i>
        
        <div class="max-w-md w-full space-y-8 relative z-10">
            <!-- Header -->
            <div class="text-center">
                <div class="mx-auto h-20 w-20 bg-white rounded-full flex items-center justify-center shadow-lg mb-6">
                    <i class="fas fa-user-lock text-3xl text-purple-600"></i>
                </div>
                <h2 class="text-4xl font-bold text-white mb-2">Đổi Mật Khẩu</h2>
                <p class="text-purple-100">Bảo mật tài khoản của bạn</p>
            </div>

            <!-- Form Card -->
            <div class="glass-card rounded-2xl p-8">
                <form method="POST" action="/account/change-password" class="space-y-6">
                    <!-- Old Password -->
                    <div class="input-group">
                        <label for="oldPassword" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-unlock-alt mr-2 text-purple-500"></i>
                            Mật khẩu cũ
                        </label>
                        <div class="relative">
                            <input type="password" 
                                   id="oldPassword" 
                                   name="oldPassword"
                                   class="input-field w-full px-4 py-3 pl-12 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                                   placeholder="Nhập mật khẩu hiện tại"
                                   required />
                            <i class="fas fa-lock absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <c:if test="${not empty error1}">
                            <p class="error-message mt-2 text-sm text-red-500 flex items-center">
                                <i class="fas fa-exclamation-circle mr-2"></i>
                                ${error1}
                            </p>
                        </c:if>
                    </div>

                    <!-- New Password -->
                    <div class="input-group">
                        <label for="newPassword" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-key mr-2 text-purple-500"></i>
                            Mật khẩu mới
                        </label>
                        <div class="relative">
                            <input type="password" 
                                   id="newPassword" 
                                   name="newPassword"
                                   class="input-field w-full px-4 py-3 pl-12 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                                   placeholder="Nhập mật khẩu mới"
                                   required />
                            <i class="fas fa-key absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <div class="password-strength">
                            <div class="strength-bar bg-gradient-to-r from-red-400 to-green-400" style="width: 0%"></div>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="input-group">
                        <label for="confirmNewPassword" class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-check-double mr-2 text-purple-500"></i>
                            Nhập lại mật khẩu mới
                        </label>
                        <div class="relative">
                            <input type="password" 
                                   id="confirmNewPassword" 
                                   name="confirmNewPassword"
                                   class="input-field w-full px-4 py-3 pl-12 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                                   placeholder="Xác nhận mật khẩu mới"
                                   required />
                            <i class="fas fa-shield-alt absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <c:if test="${not empty error}">
                            <p class="error-message mt-2 text-sm text-red-500 flex items-center">
                                <i class="fas fa-exclamation-circle mr-2"></i>
                                ${error}
                            </p>
                        </c:if>
                    </div>

                    <!-- Submit Button -->
                    <div class="pt-4">
                        <button type="submit"
                                class="btn-primary w-full py-3 px-6 text-white font-semibold rounded-xl hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2 relative overflow-hidden">
                            <span class="relative z-10 flex items-center justify-center">
                                <i class="fas fa-sync-alt mr-2"></i>
                                Đổi mật khẩu
                            </span>
                        </button>
                    </div>

                    <!-- Global Error -->
                    <c:if test="${not empty error2}">
                        <div class="error-message bg-red-50 border border-red-200 rounded-xl p-4">
                            <p class="text-sm text-red-600 flex items-center">
                                <i class="fas fa-exclamation-triangle mr-2"></i>
                                ${error2}
                            </p>
                        </div>
                    </c:if>
                </form>

                <!-- Security Tips -->
                <div class="mt-6 pt-6 border-t border-gray-200">
                    <div class="text-center">
                        <h3 class="text-sm font-semibold text-gray-700 mb-3">
                            <i class="fas fa-lightbulb mr-2 text-yellow-500"></i>
                            Gợi ý bảo mật
                        </h3>
                        <div class="grid grid-cols-2 gap-4 text-xs text-gray-600">
                            <div class="flex items-center">
                                <i class="fas fa-check-circle mr-2 text-green-500"></i>
                                Ít nhất 8 ký tự
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle mr-2 text-green-500"></i>
                                Chữ hoa và thường
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle mr-2 text-green-500"></i>
                                Có số và ký tự đặc biệt
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle mr-2 text-green-500"></i>
                                Khác mật khẩu cũ
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password strength indicator
        document.getElementById('newPassword').addEventListener('input', function(e) {
            const password = e.target.value;
            const strengthBar = document.querySelector('.strength-bar');
            let strength = 0;
            
            if (password.length >= 8) strength += 25;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength += 25;
            if (/\d/.test(password)) strength += 25;
            if (/[^A-Za-z0-9]/.test(password)) strength += 25;
            
            strengthBar.style.width = strength + '%';
            
            if (strength < 50) {
                strengthBar.className = 'strength-bar bg-red-400';
            } else if (strength < 75) {
                strengthBar.className = 'strength-bar bg-yellow-400';
            } else {
                strengthBar.className = 'strength-bar bg-green-400';
            }
        });

        // Password confirmation validation
        document.getElementById('confirmNewPassword').addEventListener('input', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = e.target.value;
            
            if (confirmPassword && newPassword !== confirmPassword) {
                e.target.style.borderColor = '#ef4444';
            } else {
                e.target.style.borderColor = '#d1d5db';
            }
        });
    </script>
</body>
</html>