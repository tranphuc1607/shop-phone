<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Đăng nhập</title>
</head>
<body class="bg-gray-100">

<div class="max-w-md mx-auto mt-16 p-8 bg-white shadow-lg rounded-lg">
    <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Đăng nhập tài khoản</h2>

    <form action="/login" method="post" class="space-y-4">
        <div>
            <label class="block mb-1 font-medium">Email</label>
            <input type="text" name="username"
                   class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                   placeholder="Nhập email của bạn">
        </div>

        <div>
            <label class="block mb-1 font-medium">Mật khẩu</label>
            <input type="password" name="password"
                   class="w-full px-3 py-2 border rounded-lg"
                   placeholder="Nhập mật khẩu">
        </div>

        <c:if test="${not empty AuthenError}">
            <p class="text-red-500 text-sm ${not empty error} ? 'hidden' : ''}">
            	${AuthenError}
            </p>
        </c:if>
		<c:if test="${not empty EmailError}">
            <p class="text-red-500 text-sm ${not empty error} ? 'hidden' : ''}">
            	${EmailError}
            </p>
        </c:if>
        <c:if test="${not empty SystemError}">
            <p class="text-red-500 text-sm ${not empty error} ? 'hidden' : ''}">
            	${SystemError }
            </p>
        </c:if>
        <div class="text-center">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg">
                Đăng nhập
            </button>
        </div>
    </form>

    <div class="mt-4 text-center text-sm">
        Chưa có tài khoản?
        <a href="/register" class="text-blue-600 hover:underline">Đăng ký ngay</a>
    </div>
</div>

</body>
</html>
