<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 font-sans">
<jsp:include page="../layout/layout.jsp"/>

<div class="container mx-auto py-10">
    <h2 class="text-3xl font-bold text-gray-700 mb-6">Lịch sử đơn hàng</h2>

    <table class="min-w-full text-sm text-left bg-white rounded-lg shadow-md overflow-hidden">
        <thead class="bg-gray-200 text-gray-600 uppercase text-xs">
            <tr>
                <th class="px-6 py-3">Ngày đặt</th>
                <th class="px-6 py-3">Phương thức thanh toán</th>
                <th class="px-6 py-3">Địa chỉ giao hàng</th>
                <th class="px-6 py-3">Trạng thái</th>
                <th class="px-6 py-3">Tổng tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr class="border-t hover:bg-gray-50">
                    <td class="px-6 py-4">
                        <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd-MM-yyyy HH:mm" />
                    </td>
                    <td class="px-6 py-4">${order.paymentMethod}</td>
                    <td class="px-6 py-4">${order.shippingAddress}</td>
                    <td class="px-6 py-4 text-blue-600 font-semibold">${order.status}</td>
                    <td class="px-6 py-4 text-green-600 font-bold">
                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
