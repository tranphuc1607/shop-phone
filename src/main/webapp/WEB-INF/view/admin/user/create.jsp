<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create user</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-3xl p-8 bg-white rounded-lg shadow-md">
        <h1 class="text-2xl font-bold mb-6 text-center">Tạo mới người dùng</h1>
        <hr class="mb-6">

        <form:form method="post" action="/admin/user/create" modelAttribute="newUser" class="grid grid-cols-1 md:grid-cols-2 gap-4" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div class="flex flex-col">
                <c:set var="errorEmail">
                    <form:errors path="email" />
                </c:set>
                <label for="email" class="text-sm font-medium mb-1">Email</label>
                <form:input type="email" id="email"
                    class="border rounded-md p-2 ${not empty errorEmail ? 'border-red-500' : 'border-gray-300'}" 
                    path="email" />
                <form:errors path="email" cssClass="text-red-500 text-xs mt-1" />
            </div>

            <div class="flex flex-col">
                <c:set var="errorPassword">
                    <form:errors path="password" />
                </c:set>
                <label for="password" class="text-sm font-medium mb-1">Mật khẩu</label>
                <form:input type="password" id="password"
                    class="border rounded-md p-2 ${not empty errorPassword ? 'border-red-500' : 'border-gray-300'}"
                    path="password" />
                <form:errors path="password" cssClass="text-red-500 text-xs mt-1" />
            </div>

            <div class="flex flex-col">
                <c:set var="errorName">
                    <form:errors path="name" />
                </c:set>
                <label for="name" class="text-sm font-medium mb-1">Tên đầy đủ</label>
                <form:input type="text" id="name"
                    class="border rounded-md p-2 ${not empty errorName ? 'border-red-500' : 'border-gray-300'}"
                    path="name" />
                <form:errors path="name" cssClass="text-red-500 text-xs mt-1" />
            </div>

            <div class="flex flex-col">
                <c:set var="errorPhone">
                    <form:errors path="phone" />
                </c:set>
                <label for="phone" class="text-sm font-medium mb-1">Số điện thoại</label>
                <form:input type="text" id="phone" class="border border-gray-300 rounded-md p-2" path="phone" />
                <form:errors path="phone" cssClass="text-red-500 text-xs mt-1" />
            </div>

            <div class="flex flex-col md:col-span-2">
                <label for="address" class="text-sm font-medium mb-1">Địa chỉ</label>
                <form:input type="text" id="address" class="border border-gray-300 rounded-md p-2" path="address" />
            </div>

            <div class="flex flex-col">
                <label for="role" class="text-sm font-medium mb-1">Vai trò</label>
                <form:select id="role" path="role" class="border border-gray-300 rounded-md p-2">
                    <form:option value="ADMIN">Quản lí</form:option>
                    <form:option value="USER">Người dùng</form:option>
                </form:select>
            </div>

            <div class="md:col-span-2 flex justify-between">
                <button type="submit"
                    class="w-[40%] bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md transition">
                    Tạo người dùng
                </button>
                <a href = "/admin/user" class="w-[30%] bg-gray-500 text-white text-center leading-[-20px] ">
                    
                    Quay lại
                </a>
            </div>
        </form:form>
    </div>
</body>

</html>
