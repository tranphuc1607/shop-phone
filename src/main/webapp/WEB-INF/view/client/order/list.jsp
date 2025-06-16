<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .glass-effect {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .status-badge {
            position: relative;
            overflow: hidden;
        }
        .status-badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }
        .status-badge:hover::before {
            left: 100%;
        }
        .animate-fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .stagger-animation {
            animation-delay: calc(var(--index) * 0.1s);
        }
    </style>
</head>
<body class="min-h-screen gradient-bg">
    <jsp:include page="../layout/layout.jsp"/>
    
    <div class="container mx-auto px-4 py-12">
        <!-- Header Section -->
        <div class="text-center mb-12 animate-fade-in">
            <h1 class="text-5xl font-bold text-white mb-4 tracking-tight">
                Lịch sử đơn hàng
            </h1>
            <div class="w-24 h-1 bg-white rounded-full mx-auto opacity-80"></div>
        </div>

        <!-- Desktop Table View -->
        <div class="hidden lg:block glass-effect rounded-2xl overflow-hidden shadow-2xl animate-fade-in">
            <div class="overflow-x-auto">
                <table class="min-w-full">
                    <thead class="bg-gradient-to-r from-gray-800 to-gray-900 text-white">
                        <tr>
                            <th class="px-8 py-6 text-left text-sm font-semibold uppercase tracking-wider">
                                <div class="flex items-center space-x-2">
                                    <span>📅</span>
                                    <span>Ngày đặt</span>
                                </div>
                            </th>
                            <th class="px-8 py-6 text-left text-sm font-semibold uppercase tracking-wider">
                                <div class="flex items-center space-x-2">
                                    <span>💳</span>
                                    <span>Thanh toán</span>
                                </div>
                            </th>
                            <th class="px-8 py-6 text-left text-sm font-semibold uppercase tracking-wider">
                                <div class="flex items-center space-x-2">
                                    <span>📍</span>
                                    <span>Địa chỉ giao hàng</span>
                                </div>
                            </th>
                            <th class="px-8 py-6 text-left text-sm font-semibold uppercase tracking-wider">
                                <div class="flex items-center space-x-2">
                                    <span>📋</span>
                                    <span>Trạng thái</span>
                                </div>
                            </th>
                            <th class="px-8 py-6 text-left text-sm font-semibold uppercase tracking-wider">
                                <div class="flex items-center space-x-2">
                                    <span>💰</span>
                                    <span>Tổng tiền</span>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach var="order" items="${orders}" varStatus="status">
                            <tr class="bg-white/90 hover:bg-white card-hover cursor-pointer animate-fade-in stagger-animation"
                                style="--index: ${status.index}"
                                onclick="goToOrderDetail('${order.id}')">
                                <td class="px-8 py-6">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-2 h-2 bg-blue-500 rounded-full"></div>
                                        <span class="text-gray-800 font-medium">
                                            <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd-MM-yyyy HH:mm" />
                                        </span>
                                    </div>
                                </td>
                                <td class="px-8 py-6">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-800">
                                        ${order.paymentMethod}
                                    </span>
                                </td>
                                <td class="px-8 py-6">
                                    <p class="text-gray-600 text-sm max-w-xs truncate" title="${order.shippingAddress}">
                                        ${order.shippingAddress}
                                    </p>
                                </td>
                                <td class="px-8 py-6">
                                    <span class="status-badge inline-flex items-center px-4 py-2 rounded-full text-sm font-semibold bg-gradient-to-r from-blue-500 to-blue-600 text-white shadow-lg">
                                        ${order.status}
                                    </span>
                                </td>
                                <td class="px-8 py-6">
                                    <span class="text-2xl font-bold bg-gradient-to-r from-green-600 to-emerald-600 bg-clip-text text-transparent">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Mobile Card View -->
        <div class="lg:hidden space-y-6">
            <c:forEach var="order" items="${orders}" varStatus="status">
                <div class="glass-effect rounded-2xl p-6 shadow-xl card-hover cursor-pointer animate-fade-in stagger-animation"
                     style="--index: ${status.index}"
                     onclick="goToOrderDetail('${order.id}')">
                    <div class="flex justify-between items-start mb-4">
                        <div class="flex items-center space-x-3">
                            <div class="w-3 h-3 bg-blue-500 rounded-full"></div>
                            <span class="text-white font-semibold text-lg">
                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd-MM-yyyy" />
                            </span>
                        </div>
                        <span class="status-badge inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-gradient-to-r from-blue-500 to-blue-600 text-white">
                            ${order.status}
                        </span>
                    </div>
                    
                    <div class="space-y-3 text-white/90">
                        <div class="flex items-center space-x-2">
                            <span>💳</span>
                            <span class="text-sm">${order.paymentMethod}</span>
                        </div>
                        <div class="flex items-start space-x-2">
                            <span>📍</span>
                            <span class="text-sm flex-1">${order.shippingAddress}</span>
                        </div>
                    </div>
                    
                    <div class="mt-4 pt-4 border-t border-white/20">
                        <div class="flex justify-between items-center">
                            <span class="text-white/80 text-sm">Tổng tiền:</span>
                            <span class="text-2xl font-bold text-green-400">
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State -->
        <c:if test="${empty orders}">
            <div class="text-center py-20 animate-fade-in">
                <div class="glass-effect rounded-3xl p-12 max-w-md mx-auto">
                    <div class="text-8xl mb-6">🛒</div>
                    <h3 class="text-2xl font-bold text-white mb-4">Chưa có đơn hàng nào</h3>
                    <p class="text-white/80 text-lg mb-8">Bạn chưa thực hiện đơn hàng nào. Hãy bắt đầu mua sắm ngay!</p>
                    <button class="bg-gradient-to-r from-purple-500 to-pink-500 text-white px-8 py-3 rounded-full font-semibold hover:shadow-lg transition-all duration-300 transform hover:scale-105">
                        Bắt đầu mua sắm
                    </button>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        function goToOrderDetail(orderId) {
            window.location.href = '${pageContext.request.contextPath}/order_his/detail?id=' + orderId;
        }

        // Add stagger animation to rows
        document.addEventListener('DOMContentLoaded', function() {
            const animatedElements = document.querySelectorAll('.stagger-animation');
            animatedElements.forEach((el, index) => {
                el.style.setProperty('--index', index);
            });
        });
    </script>
</body>
</html>