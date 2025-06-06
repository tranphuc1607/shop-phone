<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
           <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase History</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
</head>

<body class="bg-gray-100 font-sans">
    <jsp:include page="../layout/layout.jsp" />
    
<div class="container mx-auto py-10">
    <div class="bg-white shadow-md rounded-lg p-6">
        
        <c:if test="${empty cartItems}">
            <h3 class="text-center text-red-600 text-xl font-semibold mb-6">Giỏ hàng của bạn đang trống</h3>
        </c:if>

        <c:if test="${not empty cartItems}">
            <table class="min-w-full text-sm text-left mb-6">
                <thead class="bg-gray-200 text-gray-700 uppercase">
                    <tr>
                        <th class="py-3 px-4">Tên sản phẩm</th>
                        <th class="py-3 px-4">Đơn giá</th>
                        <th class="py-3 px-4">Số lượng</th>
                        <th class="py-3 px-4">Tổng</th>
                        <th class="py-3 px-4">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cartItem" items="${cartItems}">
                        <tr class="border-t hover:bg-gray-100">
                            <td class="py-3 px-4">${cartItem.productName}</td>
                            <td class="py-3 px-4 text-green-600">
                                <fmt:formatNumber value="${cartItem.productPrice}" type="currency" currencySymbol="₫" />
                            </td>
                            <td class="py-3 px-4">${cartItem.quantity}</td>
                            <td class="py-3 px-4 text-blue-600">
                                <fmt:formatNumber value="${cartItem.productPrice * cartItem.quantity}" type="currency" currencySymbol="₫" />
                            </td>
                            <td class="py-2 px-4 space-x-2 flex items-center justify-between w-[100px]">
                                <!-- Xem chi tiết / chỉnh sửa số lượng -->
                                  <form action="/cart/cartItem/detail/${cartItem.cartItemId}" method="post" style="display:inline;">
                                    <input type="hidden" name="quantity" id="quantityInput" value=${cartItem.quantity} />
                                    <button type="submit" class="text-white px-3 py-1 rounded" style="background: none; border: none;">
                                        <svg class="w-[20px] h-[20px] hover:fill-yellow-800 duration-100" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <path d="M352 320c88.4 0 160-71.6 160-160c0-15.3-2.2-30.1-6.2-44.2c-3.1-10.8-16.4-13.2-24.3-5.3l-76.8 76.8c-3 3-7.1 4.7-11.3 4.7L336 192c-8.8 0-16-7.2-16-16l0-57.4c0-4.2 1.7-8.3 4.7-11.3l76.8-76.8c7.9-7.9 5.4-21.2-5.3-24.3C382.1 2.2 367.3 0 352 0C263.6 0 192 71.6 192 160c0 19.1 3.4 37.5 9.5 54.5L19.9 396.1C7.2 408.8 0 426.1 0 444.1C0 481.6 30.4 512 67.9 512c18 0 35.3-7.2 48-19.9L297.5 310.5c17 6.2 35.4 9.5 54.5 9.5zM80 408a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/>
                                        </svg>

                                    </button>
                                </form>
                                 <!-- Xóa sản phẩm khỏi giỏ hàng -->
                                  <form action="/cart/delete/${cartItem.cartItemId}" method="post"  style="display:inline;">
                                    <button type="submit" class="text-white px-3 py-1 rounded" style="background: none; border: none;">
                                        <svg class="w-[20px] h-[20px] hover:fill-red-700 duration-100" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                                            <path d="M135.2 17.7L128 32 32 32C14.3 32 0 46.3 0 64S14.3 96 32 96l384 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-96 0-7.2-14.3C307.4 6.8 296.3 0 284.2 0L163.8 0c-12.1 0-23.2 6.8-28.6 17.7zM416 128L32 128 53.2 467c1.6 25.3 22.6 45 47.9 45l245.8 0c25.3 0 46.3-19.7 47.9-45L416 128z"/>
                                        </svg>
                                    </button>
                                </form>
                                
                            </td>
                        </tr>
                    </c:forEach>
                   
                </tbody>
            </table>
             <c:if test = "${not empty error}">
                      <div class="bg-red-100 text-red-700 p-4 rounded-lg mb-6">
                        <strong>Lỗi:</strong> ${error}
                        </div>
                    </c:if>
        </c:if>
        <!-- Action buttons -->
            <div class="flex justify-end gap-4 mt-6">
                <a href="/orders" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">
                    Xem lịch sử đặt hàng
                </a>
                <a href="/product" class="bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded">
                    Thêm sản phẩm
                </a>
                <c:if test="${not empty cartItems}">
                    <form action="/cart/checkout" method="post">
                        <button type="submit" class="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded">
                            Đặt hàng
                        </button>
                    </form>
                </c:if>
                
            </div>
    </div>
</div>
</body>

</html>
