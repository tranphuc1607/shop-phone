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
        <div class="overflow-x-auto bg-white shadow-md rounded-lg p-6">
            <table class="min-w-full text-sm text-left">
                <thead class="bg-gray-200 text-gray-700 uppercase">
                    <tr>
                        <th class="py-3 px-4">Products</th>
                        <th class="py-3 px-4">Name</th>
                        <th class="py-3 px-4">Price</th>
                        <th class="py-3 px-4">Quantity</th>
                        <th class="py-3 px-4">Total</th>
                        <th class="py-3 px-4">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${orders.size() > 0}">
                        <c:forEach var="order" items="${orders}">
                            <tr class="bg-green-50 font-semibold">
                                <td colspan="2" class="py-2 px-4 text-green-600">Order ID: ${order.getId()}</td>
                                <td colspan="2"></td>
                                <td class="py-2 px-4 text-green-600">
                                    <fmt:formatNumber value="${order.getTotalPrice()}" /> VND
                                </td>
                                <td class="py-2 px-4 text-red-500">${order.getStatus()}</td>
                            </tr>
                            <c:forEach var="orderDetail" items="${order.getOrderDetails()}">
                                <tr class="border-t">
                                    <td class="py-3 px-4">
                                        <img src="/images/products/${orderDetail.getProduct().getImage()}" alt=""
                                             class="w-16 h-16 rounded-full object-cover">
                                    </td>
                                    <td class="py-3 px-4">${orderDetail.getProduct().getName()}</td>
                                    <td class="py-3 px-4">
                                        <fmt:formatNumber value="${orderDetail.getPrice()}" /> VND
                                    </td>
                                    <td class="py-3 px-4">${orderDetail.getQuantity()}</td>
                                    <td class="py-3 px-4">
                                        <fmt:formatNumber value="${orderDetail.getPrice()*orderDetail.getQuantity()}" /> VND
                                    </td>
                                    <td class="py-3 px-4"></td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>

            <c:if test="${orders.size() == 0}">
                <h3 class="text-center text-green-600 text-xl font-semibold mt-6">Purchase history is empty</h3>
            </c:if>
        </div>
    </div>
</body>

</html>
