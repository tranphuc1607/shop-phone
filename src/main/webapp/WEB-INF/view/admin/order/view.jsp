<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-slate-50 to-blue-50 min-h-screen font-sans">
    
    <div class="container mx-auto p-4 lg:p-8 max-w-6xl">
        <!-- Header -->
        <div class="bg-white rounded-2xl shadow-lg p-6 mb-8 border border-gray-100">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl lg:text-4xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent mb-2">
                        Chi tiết đơn hàng
                    </h1>
                    <p class="text-gray-500">Thông tin chi tiết về đơn hàng của bạn</p>
                </div>
                <div class="hidden md:block">
                    <div class="w-16 h-16 bg-gradient-to-r from-blue-500 to-purple-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-receipt text-white text-2xl"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="bg-red-50 border-l-4 border-red-400 p-4 rounded-lg mb-6 shadow-sm">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-triangle text-red-400 mr-3"></i>
                    <p class="text-red-700 font-medium">${errorMessage}</p>
                </div>
            </div>
        </c:if>

        <div class="grid lg:grid-cols-3 gap-8">
            <!-- Main Order Info -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Order Summary Card -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
                    <div class="bg-gradient-to-r from-blue-500 to-purple-500 p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <h2 class="text-2xl font-bold mb-1">Đơn hàng #${order.id}</h2>
                                <p class="opacity-90">
                                    <i class="fas fa-calendar-alt mr-2"></i>
                                    <fmt:formatDate value="${createdAtDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                </p>
                            </div>
                            <div class="text-right">
                                <div class="bg-white bg-opacity-20 rounded-full px-4 py-2 inline-block">
                                    <span class="font-semibold">${order.status}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-6">
                        <div class="grid md:grid-cols-2 gap-6">
                            <div class="space-y-4">
                                <div class="flex items-center">
                                    <i class="fas fa-dollar-sign w-5 text-green-500 mr-3"></i>
                                    <div>
                                        <p class="text-sm text-gray-500">Tổng giá trị</p>
                                        <p class="font-bold text-lg text-gray-800">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="flex items-center">
                                    <i class="fas fa-credit-card w-5 text-blue-500 mr-3"></i>
                                    <div>
                                        <p class="text-sm text-gray-500">Phương thức thanh toán</p>
                                        <p class="font-semibold text-gray-800">${order.paymentMethod}</p>
                                    </div>
                                </div>
                            </div>
                            
                            <div>
                                <div class="flex items-start">
                                    <i class="fas fa-map-marker-alt w-5 text-red-500 mr-3 mt-1"></i>
                                    <div>
                                        <p class="text-sm text-gray-500 mb-1">Địa chỉ giao hàng</p>
                                        <p class="text-gray-800 leading-relaxed">${order.shippingAddress}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products Table -->
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
                    <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                        <h3 class="text-xl font-bold text-gray-800 flex items-center">
                            <i class="fas fa-shopping-bag mr-3 text-purple-500"></i>
                            Sản phẩm trong đơn hàng
                        </h3>
                    </div>
                    
                    <div class="overflow-x-auto">
                        <table class="min-w-full">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Tên sản phẩm</th>
                                    <th class="px-6 py-4 text-center text-sm font-semibold text-gray-700">Số lượng</th>
                                    <th class="px-6 py-4 text-right text-sm font-semibold text-gray-700">Giá</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="item" items="${order.items}">
                                    <tr class="hover:bg-gray-50 transition-colors duration-200">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center">
                                                <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                                                <span class="text-gray-800 font-medium">${item.product.name}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                                                ${item.quantity}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <span class="font-bold text-gray-800">
                                                <fmt:formatNumber value="${item.price}" type="currency"/>
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Customer Info Sidebar -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden sticky top-8">
                    <div class="bg-gradient-to-r from-green-500 to-teal-500 p-6 text-white">
                        <h3 class="text-xl font-bold flex items-center">
                            <i class="fas fa-user-circle mr-3"></i>
                            Thông tin khách hàng
                        </h3>
                    </div>
                    
                    <div class="p-6 space-y-4">
                        <div class="flex items-center p-4 bg-gray-50 rounded-xl">
                            <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-500 rounded-full flex items-center justify-center mr-4">
                                <i class="fas fa-user text-white"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Tên khách hàng</p>
                                <p class="font-bold text-gray-800">${order.user.name}</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center p-4 bg-gray-50 rounded-xl">
                            <div class="w-12 h-12 bg-gradient-to-r from-green-500 to-teal-500 rounded-full flex items-center justify-center mr-4">
                                <i class="fas fa-envelope text-white"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Email</p>
                                <p class="font-semibold text-gray-800 break-all">${order.user.email}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="text-center mt-8">
            <a href="/admin/order/all" class="inline-flex items-center px-8 py-4 bg-gradient-to-r from-blue-600 to-purple-600 text-white text-lg font-semibold rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                <i class="fas fa-arrow-left mr-3"></i>
                Quay lại
            </a>
        </div>
    </div>

</body>
</html>