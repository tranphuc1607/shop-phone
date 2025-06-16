<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        .order-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .status-pending { 
            background-color: #ffc107; 
            color: #000; 
        }
        .status-confirmed { 
            background-color: #17a2b8; 
            color: #fff; 
        }
        .status-shipping { 
            background-color: #fd7e14; 
            color: #fff; 
        }
        .status-delivered { 
            background-color: #28a745; 
            color: #fff; 
        }
        .status-cancelled { 
            background-color: #dc3545; 
            color: #fff; 
        }
        
        .timeline-line::before {
            content: '';
            position: absolute;
            left: 11px;
            top: 24px;
            width: 2px;
            height: calc(100% + 1rem);
            background: #e5e7eb;
        }
        
        .timeline-completed .timeline-line::before {
            background: #10b981;
        }
    </style>
</head>
<body class="bg-gray-50">
    <!-- Include header layout -->
    <jsp:include page="../layout/layout.jsp"/>
    
    <!-- Main content -->
    <div class="min-h-screen">
        <!-- Header Section -->
        <div class="order-header text-white py-8 mb-8">
            <div class="container mx-auto px-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-3xl font-bold flex items-center">
                            <i class="fas fa-receipt mr-3"></i>Chi tiết đơn hàng
                        </h2>
                        <c:if test="${not empty order}">
                            <p class="text-lg opacity-90 mt-2">Đơn hàng #${order.id}</p>
                        </c:if>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/order/order-list" 
                           class="bg-white bg-opacity-20 hover:bg-opacity-30 text-white px-6 py-3 rounded-full transition-all duration-300 hover:shadow-lg hover:-translate-y-1 inline-flex items-center">
                            <i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mx-auto px-4">
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-center">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span>${error}</span>
                    <button type="button" class="ml-auto" onclick="this.parentElement.style.display='none'">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </c:if>

            <!-- Order Details -->
            <c:if test="${not empty order}">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left Column - Order Info & Items -->
                    <div class="lg:col-span-2 space-y-6">
                        <!-- Order Information -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="bg-blue-600 text-white px-6 py-4">
                                <h5 class="text-lg font-semibold flex items-center">
                                    <i class="fas fa-info-circle mr-2"></i>Thông tin đơn hàng
                                </h5>
                            </div>
                            <div class="p-6">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-4">
                                        <div>
                                            <span class="font-semibold text-gray-700">Mã đơn hàng:</span>
                                            <span class="ml-2 text-blue-600 font-mono">#${order.id}</span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Ngày đặt:</span>
                                            <span class="ml-2 text-gray-900">
                                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Trạng thái:</span>
                                            <c:choose>
                                                <c:when test="${order.status == 'pending' || order.status == 'PENDING'}">
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-pending">Chờ xác nhận</span>
                                                </c:when>
                                                <c:when test="${order.status == 'confirmed' || order.status == 'CONFIRMED'}">
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-confirmed">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${order.status == 'shipping' || order.status == 'SHIPPING'}">
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-shipping">Đang giao hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'delivered' || order.status == 'DELIVERED'}">
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-delivered">Đã giao hàng</span>
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled' || order.status == 'CANCELLED'}">
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-cancelled">Đã hủy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="ml-2 inline-block px-3 py-1 rounded-full text-sm font-medium status-pending">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="space-y-4">
                                        <div>
                                            <span class="font-semibold text-gray-700">Phương thức thanh toán:</span>
                                            <span class="ml-2 text-gray-900">
                                                <c:choose>
                                                    <c:when test="${order.paymentMethod == 'cash'}">Thanh toán khi nhận hàng</c:when>
                                                    <c:when test="${order.paymentMethod == 'card'}">Thẻ tín dụng</c:when>
                                                    <c:when test="${order.paymentMethod == 'bank'}">Chuyển khoản ngân hàng</c:when>
                                                    <c:otherwise>${order.paymentMethod}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Khách hàng:</span>
                                            <span class="ml-2 text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty order.user.name}">
                                                        ${order.user.name}
                                                    </c:when>
                                                    <c:when test="${not empty order.user.name}">
                                                        ${order.user.name}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Khách hàng #${order.user.id}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <c:if test="${not empty order.user.email}">
                                            <div>
                                                <span class="font-semibold text-gray-700">Email:</span>
                                                <span class="ml-2 text-blue-600">${order.user.email}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <hr class="my-6 border-gray-200">
                                
                                <div>
                                    <h6 class="font-semibold text-gray-700 flex items-center mb-3">
                                        <i class="fas fa-map-marker-alt mr-2 text-red-500"></i>Địa chỉ giao hàng:
                                    </h6>
                                    <p class="text-gray-600 leading-relaxed">${order.shippingAddress}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Order Items -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="bg-green-600 text-white px-6 py-4">
                                <h5 class="text-lg font-semibold flex items-center">
                                    <i class="fas fa-shopping-cart mr-2"></i>Sản phẩm đã đặt
                                </h5>
                            </div>
                            <div class="p-6">
                                <div class="space-y-4">
                                    <c:forEach var="item" items="${order.items}">
                                        <div class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                                            <div class="flex-1">
                                                <h6 class="font-semibold text-gray-900 mb-1">${item.product.name}</h6>
                                                <p class="text-sm text-gray-500">${item.product.description}</p>
                                            </div>
                                            <div class="text-center mx-4">
                                                <span class="bg-gray-100 text-gray-800 px-3 py-1 rounded-full text-sm font-medium">
                                                    SL: ${item.quantity}
                                                </span>
                                            </div>
                                            <div class="text-right">
                                                <p class="font-bold text-lg text-gray-900">
                                                    <fmt:formatNumber value="${item.price}" type="number" pattern="#,###" /> VNĐ
                                                </p>
                                                <p class="text-sm text-gray-500">
                                                    Đơn giá: <fmt:formatNumber value="${item.price / item.quantity}" type="number" pattern="#,###" /> VNĐ
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Summary & Tracking -->
                    <div class="space-y-6">
                        <!-- Order Summary -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="bg-amber-500 text-white px-6 py-4">
                                <h5 class="text-lg font-semibold flex items-center">
                                    <i class="fas fa-calculator mr-2"></i>Tổng kết đơn hàng
                                </h5>
                            </div>
                            <div class="p-6">
                                <div class="bg-gray-50 rounded-lg p-4 space-y-3">
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-600">Tổng sản phẩm:</span>
                                        <span class="font-medium">${order.items.size()}</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-600">Tạm tính:</span>
                                        <span class="font-medium">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,###" /> VNĐ
                                        </span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-600">Phí vận chuyển:</span>
                                        <span class="text-green-600 font-medium">Miễn phí</span>
                                    </div>
                                    <hr class="border-gray-300">
                                    <div class="flex justify-between items-center text-lg">
                                        <span class="font-bold text-gray-900">Tổng cộng:</span>
                                        <span class="font-bold text-blue-600">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,###" /> VNĐ
                                        </span>
                                    </div>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="mt-6 space-y-3">
                                    <c:if test="${order.status == 'pending' || order.status == 'PENDING'}">
                                        <button onclick="cancelOrder(${order.id})" 
                                                class="w-full bg-red-600 hover:bg-red-700 text-white py-2 px-4 rounded-lg transition-colors flex items-center justify-center">
                                            <i class="fas fa-times mr-2"></i>Hủy đơn hàng
                                        </button>
                                    </c:if>
                                    <c:if test="${order.status == 'delivered' || order.status == 'DELIVERED'}">
                                        <button class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-lg transition-colors flex items-center justify-center">
                                            <i class="fas fa-star mr-2"></i>Đánh giá sản phẩm
                                        </button>
                                    </c:if>
                                    <button onclick="printInvoice()" 
                                            class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded-lg transition-colors flex items-center justify-center">
                                        <i class="fas fa-print mr-2"></i>In hóa đơn
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Order Tracking -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="bg-cyan-600 text-white px-6 py-4">
                                <h5 class="text-lg font-semibold flex items-center">
                                    <i class="fas fa-truck mr-2"></i>Theo dõi đơn hàng
                                </h5>
                            </div>
                            <div class="p-6">
                                <div class="space-y-4">
                                    <div class="flex items-center">
                                        <div class="w-6 h-6 bg-green-500 rounded-full flex items-center justify-center text-white text-sm">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <div class="ml-4 flex-1">
                                            <div class="font-semibold text-gray-900">Đơn hàng đã được đặt</div>
                                            <div class="text-sm text-gray-500">
                                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center ${(order.status != 'pending' && order.status != 'PENDING') ? 'opacity-100' : 'opacity-50'}">
                                        <div class="w-6 h-6 ${(order.status != 'pending' && order.status != 'PENDING') ? 'bg-green-500' : 'bg-gray-300'} rounded-full flex items-center justify-center text-white text-sm">
                                            <i class="fas fa-clipboard-check"></i>
                                        </div>
                                        <div class="ml-4 flex-1">
                                            <div class="font-semibold text-gray-900">Đơn hàng được xác nhận</div>
                                            <div class="text-sm text-gray-500">Chờ xử lý</div>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center ${(order.status == 'shipping' || order.status == 'SHIPPING' || order.status == 'delivered' || order.status == 'DELIVERED') ? 'opacity-100' : 'opacity-50'}">
                                        <div class="w-6 h-6 ${(order.status == 'shipping' || order.status == 'SHIPPING' || order.status == 'delivered' || order.status == 'DELIVERED') ? 'bg-green-500' : 'bg-gray-300'} rounded-full flex items-center justify-center text-white text-sm">
                                            <i class="fas fa-shipping-fast"></i>
                                        </div>
                                        <div class="ml-4 flex-1">
                                            <div class="font-semibold text-gray-900">Đang giao hàng</div>
                                            <div class="text-sm text-gray-500">Đang vận chuyển</div>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center ${(order.status == 'delivered' || order.status == 'DELIVERED') ? 'opacity-100' : 'opacity-50'}">
                                        <div class="w-6 h-6 ${(order.status == 'delivered' || order.status == 'DELIVERED') ? 'bg-green-500' : 'bg-gray-300'} rounded-full flex items-center justify-center text-white text-sm">
                                            <i class="fas fa-home"></i>
                                        </div>
                                        <div class="ml-4 flex-1">
                                            <div class="font-semibold text-gray-900">Đã giao hàng</div>
                                            <div class="text-sm text-gray-500">Hoàn thành</div>
                                        </div>
                                    </div>
                                    <div class="flex items-center ${(order.status == 'CANCELED' || order.status == 'CANCELED') ? 'opacity-100' : 'opacity-50'}">
                                        <div class="w-6 h-6 ${(order.status == 'CANCELED' || order.status == 'CANCELED') ? 'bg-green-500' : 'bg-gray-300'} rounded-full flex items-center justify-center text-white text-sm">
                                            <i class="fas fa-home"></i>
                                        </div>
                                        <div class="ml-4 flex-1">
                                            <div class="font-semibold text-gray-900">Đã hủy đơn</div>
                                            <div class="text-sm text-gray-500">Canceled</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Modal xác nhận hủy đơn hàng -->
    <div id="cancelOrderModal" class="hidden fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
        <div class="bg-white rounded-xl shadow-2xl max-w-md w-full mx-4">
            <div class="p-6">
                <div class="flex items-center mb-4">
                    <i class="fas fa-exclamation-triangle text-amber-500 text-2xl mr-3"></i>
                    <h3 class="text-xl font-semibold text-gray-900">Xác nhận hủy đơn hàng</h3>
                </div>
                <p class="text-gray-600 mb-2">Bạn có chắc chắn muốn hủy đơn hàng này không?</p>
                <p class="text-sm text-gray-500 mb-6">
                    <i class="fas fa-info-circle mr-1"></i>
                    Sau khi hủy, đơn hàng sẽ không thể khôi phục lại được.
                </p>
                <div class="flex space-x-3">
                    <button onclick="closeCancelModal()" 
                            class="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-800 py-2 px-4 rounded-lg transition-colors">
                        <i class="fas fa-times mr-2"></i>Không
                    </button>
                    <button id="confirmCancelBtn" 
                            class="flex-1 bg-red-600 hover:bg-red-700 text-white py-2 px-4 rounded-lg transition-colors">
                        <i class="fas fa-check mr-2"></i>Xác nhận hủy
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let currentOrderId = null;

        // Hàm hủy đơn hàng
        function cancelOrder(orderId) {
            currentOrderId = orderId;
            document.getElementById('cancelOrderModal').classList.remove('hidden');
        }

        // Đóng modal
        function closeCancelModal() {
            document.getElementById('cancelOrderModal').classList.add('hidden');
        }

        // Xử lý xác nhận hủy đơn hàng
        document.getElementById('confirmCancelBtn').addEventListener('click', function() {
            if (currentOrderId) {
                // Hiển thị loading
                this.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang xử lý...';
                this.disabled = true;

                // Tạo form để submit đến controller
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/order_his/cancel';
                
                // Thêm CSRF token nếu có
                const csrfToken = document.querySelector('meta[name="_csrf"]');
                const csrfHeader = document.querySelector('meta[name="_csrf_header"]');
                
                if (csrfToken && csrfHeader) {
                    const csrfInput = document.createElement('input');
                    csrfInput.type = 'hidden';
                    csrfInput.name = '_token';
                    csrfInput.value = csrfToken.getAttribute('content');
                    form.appendChild(csrfInput);
                }
                
                // Thêm orderId
                const orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'orderId';
                orderIdInput.value = currentOrderId;
                form.appendChild(orderIdInput);
                
                // Submit form
                document.body.appendChild(form);
                form.submit();
            }
        });

        // Hàm in hóa đơn
        function printInvoice() {
            // Ẩn các nút không cần thiết khi in
            const buttonsToHide = document.querySelectorAll('button, .order-header a');
            buttonsToHide.forEach(btn => btn.style.display = 'none');
            
            // In trang
            window.print();
            
            // Hiển thị lại các nút sau khi in
            buttonsToHide.forEach(btn => btn.style.display = '');
        }

        // Hàm hiển thị thông báo
        function showAlert(type, message) {
            const alertDiv = document.createElement('div');
            alertDiv.className = 'fixed top-4 right-4 z-50 max-w-sm w-full';
            
            let bgColor = 'bg-green-100 border-green-400 text-green-700';
            let iconClass = 'fa-check-circle text-green-500';
            
            if (type === 'error') {
                bgColor = 'bg-red-100 border-red-400 text-red-700';
                iconClass = 'fa-exclamation-triangle text-red-500';
            }
            
            alertDiv.innerHTML = 
                '<div class="border rounded-lg p-4 shadow-lg ' + bgColor + '">' +
                    '<div class="flex items-center">' +
                        '<i class="fas ' + iconClass + ' mr-3"></i>' +
                        '<span class="flex-1">' + message + '</span>' +
                        '<button onclick="this.parentElement.parentElement.parentElement.remove()" class="ml-2">' +
                            '<i class="fas fa-times"></i>' +
                        '</button>' +
                    '</div>' +
                '</div>';
            
            document.body.appendChild(alertDiv);
            
            // Tự động ẩn sau 5 giây
            setTimeout(() => {
                if (alertDiv && alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }

        // Đóng modal khi click outside
        document.getElementById('cancelOrderModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeCancelModal();
            }
        });
    </script>
</body>
</html>