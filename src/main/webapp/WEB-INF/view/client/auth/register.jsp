<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Đăng ký tài khoản</title>
</head>
<body class="bg-gray-100" style="background: linear-gradient(90deg, #E0F7FA, #B3E5FC, #81D4FA, #4FC3F7, #29B6F6);" >

<div class="max-w-xl mx-auto bg-white shadow-lg mt-10 p-6 rounded-lg">
    <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Đăng ký tài khoản mới</h2>
	<c:if test="${not empty error}">
    	<p class="text-red-600 text-sm mb-4">${error}</p>
	</c:if>
    <form:form method="post" modelAttribute="user" cssClass="space-y-4">
        <div>
            <label class="block mb-1 font-medium">Tên</label>
            <form:input path="name" cssClass="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"/>
        </div>

        <div>
            <label class="block mb-1 font-medium">Email</label>
            <form:input path="email" cssClass="w-full px-3 py-2 border rounded-lg"/>
        </div>

        <div>
            <label class="block mb-1 font-medium">Mật khẩu</label>
            <form:password path="password" cssClass="w-full px-3 py-2 border rounded-lg"/>
        </div>

        <div>
            <label class="block mb-1 font-medium">Số điện thoại</label>
            <form:input path="phone" cssClass="w-full px-3 py-2 border rounded-lg"/>
        </div>

        <div>
            <label class="block mb-1 font-medium">Địa chỉ</label>
            <form:input path="address" cssClass="w-full px-3 py-2 border rounded-lg"/>
        </div>
		<!--  
        <div>
            <label class="block mb-1 font-medium">Vai trò</label>
            <form:select path="role" cssClass="w-full px-3 py-2 border rounded-lg">
                <form:option value="USER" label="Người dùng"/>
                <form:option value="ADMIN" label="Quản trị viên"/>
            </form:select>
        </div>
		-->
        <div class="text-center">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg">
                Đăng ký
            </button>
        </div>
    </form:form>
</div>

</body>
</html>
