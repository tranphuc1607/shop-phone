<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

    <div class="container mx-auto p-8">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">Chi tiết đơn hàng</h1>

        <div th:if="${errorMessage}" class="bg-red-100 text-red-700 p-4 rounded-lg mb-6">
            <p th:text="${errorMessage}"></p>
        </div>

        <div th:if="${order}" class="bg-white p-6 rounded-lg shadow-lg">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">
                Mã đơn hàng: <span th:text="${order.id}" class="text-blue-600"></span>
            </h2>
            <p class="text-gray-600 mb-2"><strong>Ngày dặt hàng:</strong> <span th:text="${order.orderDate}"></span></p>
            <p class="text-gray-600 mb-2"><strong>Trạng thái:</strong> <span th:text="${order.status}"></span></p>
            <p class="text-gray-600 mb-2"><strong>Tổng giá trị:</strong> <span th:text="${order.totalAmount}"></span></p>
            <p class="text-gray-600 mb-4"><strong>Phương thức thanh toán:</strong> <span th:text="${order.paymentMethod}"></span></p>
            <p class="text-gray-600 mb-6"><strong>Địa chỉ giao hàng:</strong> <span th:text="${order.shippingAddress}"></span></p>

            <h3 class="text-xl font-semibold text-gray-800 mb-4">Thông tin khách hàng</h3>
            <p class="text-gray-600 mb-2"><strong>Tên:</strong> <span th:text="${order.user.name}"></span></p>
            <p class="text-gray-600 mb-4"><strong>Emai:</strong> <span th:text="${order.user.email}"></span></p>

            <h3 class="text-xl font-semibold text-gray-800 mb-4">Sản phẩm trong đơn hàng</h3>
            <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-700">Tên sản phẩm</th>
                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-700">Số lượng</th>
                        <th class="px-6 py-3 text-left text-sm font-medium text-gray-700">Giá</th>
                    </tr>
                </thead>
                <tbody>
                    <tr th:each="item : ${order.items}">
                        <td class="px-6 py-4 text-sm text-gray-700" th:text="${item.product.name}"></td>
                        <td class="px-6 py-4 text-sm text-gray-700" th:text="${item.quantity}"></td>
                        <td class="px-6 py-4 text-sm text-gray-700" th:text="${item.price}"></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Nút Quay lại -->
        <div class="text-center mt-6">
            <a href="#" class="inline-block px-6 py-2 bg-blue-600 text-white text-lg rounded-lg shadow-md hover:bg-blue-700 transition duration-300">
                Quay lại
            </a>
        </div>
    </div>

</body>
</html>



