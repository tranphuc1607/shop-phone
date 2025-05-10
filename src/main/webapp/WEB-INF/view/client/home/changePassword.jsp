<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Link Tailwind CDN (nếu bạn chưa dùng bundler) -->
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

<div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8" 
     style="background: linear-gradient(90deg, #E0F7FA, #B3E5FC, #81D4FA, #4FC3F7, #29B6F6);">
    <div class="max-w-md w-full space-y-8">
        <h2 class="text-center text-3xl font-bold text-blue-600">Đổi Mật Khẩu</h2>
        
        <form method="POST" action="/account/change-password" class="mt-8 space-y-6">
            <div class="rounded-md shadow-sm space-y-4">
                <div>
                    <label for="oldPassword" class="block text-sm font-medium text-gray-700">Mật khẩu cũ</label>
                    <input type="password" id="oldPassword" name="oldPassword" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                           required />
                           <c:if test="${not empty error1}">
                                 <p style="color: red;">${error1}</p>
                            </c:if>
                </div>

                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-700">Mật khẩu mới</label>
                    <input type="password" id="newPassword" name="newPassword" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                           required />
                </div>
                <div>
                    <label for="confirmNewPassword" class="block text-sm font-medium text-gray-700">Mật khẩu nhập lại</label>
                    <input type="password" id="confirmNewPassword" name="confirmNewPassword" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                           required />
                           <c:if test="${not empty error}">
                                 <p style="color: red;">${error}</p>
                            </c:if>
                </div>
            </div>

            <div class="flex justify-center">
                <button type="submit"
                        class="w-full py-2 text-white bg-blue-600 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    Đổi mật khẩu
                </button>
            </div>
            <c:if test="${not empty error2}">
                 <p style="color: red;">${error2}</p>
            </c:if>
        </form>
    </div>
</div>
