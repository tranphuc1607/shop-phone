<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 font-sans">
<jsp:include page="../layout/layout.jsp" />
<form action="/cart/checkout/confirm" method="post" >
    
    <div class="container mx-auto py-10">
        <div class="bg-white shadow-md rounded-lg p-6">
            <h2 class="text-2xl font-bold mb-6 text-gray-700">THÔNG TIN GIỎ HÀNG</h2>
            <c:forEach var="item" items="${checkoutDTO.cartItems}" varStatus="status">
                <input type="hidden" name="cartItems[${status.index}].productId" value="${item.productId}" />
                <input type="hidden" name="cartItems[${status.index}].cartItemId" value="${item.cartItemId}" />
                <input type="hidden" name="cartItems[${status.index}].productName" value="${item.productName}" />
                <input type="hidden" name="cartItems[${status.index}].productPrice" value="${item.productPrice}" />
                <input type="hidden" name="cartItems[${status.index}].quantity" value="${item.quantity}" />
            </c:forEach>

            <table class="min-w-full text-sm text-left mb-6">
                <thead class="bg-gray-200 text-gray-700 uppercase">
                    <tr>
                        <th class="py-3 px-4">Tên sản phẩm</th>
                        <th class="py-3 px-4">Giá</th>
                        <th class="py-3 px-4">Số lượng</th>
                        <th class="py-3 px-4">Tổng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${checkoutDTO.cartItems}">
                        <tr class="border-t hover:bg-gray-50">
                            <td class="py-2 px-4">${item.productName}</td>
                            <td class="py-2 px-4 text-green-600">
                                <fmt:formatNumber value="${item.productPrice}" type="currency" currencySymbol=""/>
                            </td>
                            <td class="py-2 px-4">${item.quantity}</td>
                            <td class="py-2 px-4 text-blue-600">
                                <fmt:formatNumber value="${item.productPrice * item.quantity}" type="currency" currencySymbol="đ"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <p class="text-lg font-semibold mb-8">Tổng hóa đơn: 
                <input type="hidden" name="totalAmount" id="totalAmount" value="${checkoutDTO.totalAmount}" />
                <span class="text-red-600">
                    <fmt:formatNumber value="${checkoutDTO.totalAmount}" type="currency" currencySymbol="₫"/>
                </span>
            </p>

            <h2 class="text-2xl font-bold mb-4 text-gray-700">THÔNG TIN NGƯỜI ĐẶT</h2>

                <div class="grid grid-cols-2 gap-6">
                    <input type="hidden" name="userId" id = "userId" value="${checkoutDTO.userId}" />
                    <div>
                        <label for="userName" class="block text-sm font-medium">Họ tên:</label>
                        <input type="text" id="userName" name="userName" value="${checkoutDTO.userName}" 
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm" required/>
                    </div>

                    <div>
                        <label for="userEmail" class="block text-sm font-medium">Email:</label>
                        <input type="email" id="userEmail" name="userEmail" value="${checkoutDTO.userEmail}"
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm" required/>
                    </div>

                    <div>
                        <label for="userPhone" class="block text-sm font-medium">Số điện thoại:</label>
                        <input type="text" id="userPhone" name="userPhone" value="${checkoutDTO.userPhone}"
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm" required/>
                    </div>

                    <div>
                        <label for="userAddress" class="block text-sm font-medium">Địa chỉ:</label>
                        <input type="text" id="userAddress" name="userAddress" value="${checkoutDTO.userAddress}"
                            class="mt-1 block w-full rounded border-gray-300 shadow-sm" required/>
                    </div>

                    <div class="col-span-2">
                        <label for="paymentMethod" class="block text-sm font-medium">Phương thức thanh toán:</label>
                        <input type="text" id="paymentMethod" name="paymentMethod" value="${checkoutDTO.paymentMethod}"
                            class="mt-1 block w-full rounded border-gray-300 bg-gray-100 text-gray-600" readonly />
                    </div>
                </div>
                
                <div class="flex justify-end mt-6">
                    <button type="submit"
                            class="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-6 rounded">
                        Xác nhận đặt hàng
                    </button>
                </div>
                
        </div>
    </div>
</form>
</body>
</html>
