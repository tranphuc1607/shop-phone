<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Cập nhật trạng thái đơn hàng</title>
    <style>
        * {
            cursor:pointer;
        }
        @media (max-width: 1024px) {
          nav {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 50;
            height: 100vh;
            background-color: white;
            width: 260px;
            transform: translateX(-100%); 
            transition: transform 0.3s ease;
          }

          nav.show {
            transform: translateX(0);
          }
          nav.hidden {
            display :none;
          }

          header {
            width: 100%;
            left: 0;
          }

          #content {
            margin-left: 0;
          }
        }

        @media (min-width: 1025px) {
          nav {
            transform: translateX(0); 
          }

          header {
            width: calc(100% - 260px);
            left: 260px;
          }

          #content {
            margin-left: 260px;
          }
        }

        .status-card {
            transition: all 0.3s ease;
        }
        .status-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .status-active {
            border: 2px solid #3B82F6;
            background: linear-gradient(135deg, #EBF8FF 0%, #DBEAFE 100%);
        }
        .status-timeline {
            position: relative;
        }
        .status-timeline::before {
            content: '';
            position: absolute;
            left: 20px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #E5E7EB;
        }
        .timeline-item.completed::before {
            background: #10B981;
        }
        .timeline-dot {
            position: absolute;
            left: 14px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #E5E7EB;
            border: 2px solid white;
            z-index: 1;
        }
        .timeline-dot.completed {
            background: #10B981;
        }
        .timeline-dot.active {
            background: #3B82F6;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
    </style>
</head>
<body>
    <div class ="flex h-[100vh]">
      <jsp:include page="../layout/header.jsp" />
      <jsp:include page="../layout/navbar.jsp" />
      <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
        <main>
            <div class="container mx-auto p-4 max-w-4xl">
                <h1 class="text-3xl font-bold text-orange-500 mb-4">Cập nhật trạng thái đơn hàng</h1>
                <nav class ="text-sm mb-6">
                  <ol class="list-reset flex text-gray-700">
                    <li><a href="/admin/dashboard" class="text-blue-500 hover:underline">Thống kê</a></li>
                    <li><span class="mx-2">/</span></li>
                    <li><a href="/admin/order" class="text-blue-500 hover:underline">Đơn hàng</a></li>
                    <li><span class="mx-2">/</span></li>
                    <li class="text-gray-500">Cập nhật trạng thái</li>
                  </ol>
                </nav>

                <!-- Order Info Card -->
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h2 class="text-xl font-semibold mb-4 text-gray-800">Thông tin đơn hàng</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="text-gray-600"><span class="font-medium">Mã đơn hàng:</span> #${order.getId()}</p>
                            <p class="text-gray-600"><span class="font-medium">Khách hàng:</span> ${order.getUser().getName()}</p>
                            <p class="text-gray-600"><span class="font-medium">Ngày đặt:</span> ${order.getOrderDate()}</p>
                        </div>
                        <div>
                            <p class="text-gray-600"><span class="font-medium">Tổng tiền:</span> 
                                <span class="text-green-600 font-semibold">
                                    <fmt:formatNumber value="${order.getTotalAmount()}" /> VNĐ
                                </span>
                            </p>
                            <p class="text-gray-600"><span class="font-medium">Địa chỉ:</span> ${order.getShippingAddress()}</p>
                            <p class="text-gray-600"><span class="font-medium">Trạng thái hiện tại:</span> 
                                <span class="px-2 py-1 rounded text-sm font-medium
                                    ${order.getStatus() == 'Chưa xác nhận' ? 'bg-yellow-100 text-yellow-800' : 
                                      order.getStatus() == 'Đã xác nhận' ? 'bg-blue-100 text-blue-800' :
                                      order.getStatus() == 'Đang vận chuyển' ? 'bg-purple-100 text-purple-800' :
                                      'bg-green-100 text-green-800'}">
                                    ${order.getStatus()}
                                </span>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Status Update Form -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h2 class="text-xl font-semibold mb-6 text-gray-800">Cập nhật trạng thái đơn hàng</h2>
                    
                    <form:form method="POST" action="/admin/order/update/${order.getId()}" modelAttribute="order">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Status Selection -->
                            <div>
                                <h3 class="text-lg font-medium mb-4 text-gray-700">Chọn trạng thái mới</h3>
                                <div class="space-y-3">
                                    <label class="status-card flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-blue-300">
                                        <form:radiobutton path="status" value="Chưa xác nhận" class="mr-3 text-blue-600"/>
                                        <div class="flex items-center">
                                            <div class="w-3 h-3 bg-yellow-400 rounded-full mr-3"></div>
                                            <div>
                                                <div class="font-medium text-gray-800">Chưa xác nhận</div>
                                                <div class="text-sm text-gray-500">Đơn hàng mới chưa được xử lý</div>
                                            </div>
                                        </div>
                                    </label>

                                    <label class="status-card flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-blue-300">
                                        <form:radiobutton path="status" value="Đã xác nhận" class="mr-3 text-blue-600"/>
                                        <div class="flex items-center">
                                            <div class="w-3 h-3 bg-blue-400 rounded-full mr-3"></div>
                                            <div>
                                                <div class="font-medium text-gray-800">Đã xác nhận</div>
                                                <div class="text-sm text-gray-500">Đơn hàng đã được xác nhận và chuẩn bị</div>
                                            </div>
                                        </div>
                                    </label>

                                    <label class="status-card flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-blue-300">
                                        <form:radiobutton path="status" value="Đang vận chuyển" class="mr-3 text-blue-600"/>
                                        <div class="flex items-center">
                                            <div class="w-3 h-3 bg-purple-400 rounded-full mr-3"></div>
                                            <div>
                                                <div class="font-medium text-gray-800">Đang vận chuyển</div>
                                                <div class="text-sm text-gray-500">Đơn hàng đang được vận chuyển</div>
                                            </div>
                                        </div>
                                    </label>

                                    <label class="status-card flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-blue-300">
                                        <form:radiobutton path="status" value="Đã hoàn thành" class="mr-3 text-blue-600"/>
                                        <div class="flex items-center">
                                            <div class="w-3 h-3 bg-green-400 rounded-full mr-3"></div>
                                            <div>
                                                <div class="font-medium text-gray-800">Đã hoàn thành</div>
                                                <div class="text-sm text-gray-500">Đơn hàng đã được giao thành công</div>
                                            </div>
                                        </div>
                                    </label>
                                </div>
                            </div>

                            <!-- Status Timeline -->
                            <div>
                                <h3 class="text-lg font-medium mb-4 text-gray-700">Tiến trình đơn hàng</h3>
                                <div class="status-timeline pl-12 relative">
                                    <div class="space-y-6">
                                        <div class="timeline-item ${order.getStatus() == 'Chưa xác nhận' || order.getStatus() == 'Đã xác nhận' || order.getStatus() == 'Đang vận chuyển' || order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}">
                                            <div class="timeline-dot ${order.getStatus() == 'Chưa xác nhận' ? 'active' : order.getStatus() == 'Đã xác nhận' || order.getStatus() == 'Đang vận chuyển' || order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}"></div>
                                            <div class="ml-6">
                                                <div class="font-medium text-gray-800">Chưa xác nhận</div>
                                                <div class="text-sm text-gray-500">Đơn hàng được tạo</div>
                                            </div>
                                        </div>

                                        <div class="timeline-item ${order.getStatus() == 'Đã xác nhận' || order.getStatus() == 'Đang vận chuyển' || order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}">
                                            <div class="timeline-dot ${order.getStatus() == 'Đã xác nhận' ? 'active' : order.getStatus() == 'Đang vận chuyển' || order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}"></div>
                                            <div class="ml-6">
                                                <div class="font-medium text-gray-800">Đã xác nhận</div>
                                                <div class="text-sm text-gray-500">Đơn hàng được xác nhận</div>
                                            </div>
                                        </div>

                                        <div class="timeline-item ${order.getStatus() == 'Đang vận chuyển' || order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}">
                                            <div class="timeline-dot ${order.getStatus() == 'Đang vận chuyển' ? 'active' : order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}"></div>
                                            <div class="ml-6">
                                                <div class="font-medium text-gray-800">Đang vận chuyển</div>
                                                <div class="text-sm text-gray-500">Đơn hàng đang được giao</div>
                                            </div>
                                        </div>

                                        <div class="timeline-item ${order.getStatus() == 'Đã hoàn thành' ? 'completed' : ''}">
                                            <div class="timeline-dot ${order.getStatus() == 'Đã hoàn thành' ? 'active completed' : ''}"></div>
                                            <div class="ml-6">
                                                <div class="font-medium text-gray-800">Đã hoàn thành</div>
                                                <div class="text-sm text-gray-500">Đơn hàng hoàn thành</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notes Section -->
                        <div class="mt-6">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Ghi chú (tùy chọn)</label>
                            <textarea name="notes" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" placeholder="Nhập ghi chú về việc thay đổi trạng thái..."></textarea>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex justify-end space-x-4 mt-8">
                            <a href="/admin/order/all" class="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50 transition duration-200">
                                Hủy
                            </a>
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-200 shadow-sm">
                                Cập nhật trạng thái
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </main>
      </div>
    </div>

    <script>
        // Radio button selection handling
        const radioButtons = document.querySelectorAll('input[type="radio"]');
        const statusCards = document.querySelectorAll('.status-card');

        radioButtons.forEach((radio, index) => {
            radio.addEventListener('change', function() {
                // Remove active class from all cards
                statusCards.forEach(card => {
                    card.classList.remove('status-active');
                });
                
                // Add active class to selected card
                if (this.checked) {
                    statusCards[index].classList.add('status-active');
                }
            });
        });

        // Set initial active state based on current selection
        radioButtons.forEach((radio, index) => {
            if (radio.checked) {
                statusCards[index].classList.add('status-active');
            }
        });

        // Navigation toggle functionality (same as original)
        const dropdownButton = document.getElementById('dropdown');
        const dropdownMenu = document.getElementById('dropdownMenu');

        if (dropdownButton && dropdownMenu) {
            let timer;
            dropdownButton.addEventListener('click', function() {
                if (dropdownMenu.classList.contains('hidden')) {
                    dropdownMenu.classList.remove('hidden');
                    timer = setTimeout(() => {
                        dropdownMenu.classList.add('opacity-0');
                    }, 10000);
                } else {
                    dropdownMenu.classList.add('hidden');
                    dropdownMenu.classList.remove('opacity-0');
                    clearTimeout(timer);
                }
            });

            window.addEventListener('click', function(event) {
                if (!dropdownButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
                    dropdownMenu.classList.add('hidden');
                    dropdownMenu.classList.remove('opacity-0');
                    clearTimeout(timer);
                }
            });
        }

        // Mobile navigation toggle
        const toggleBtn = document.getElementById('icon--list');
        const nav = document.querySelector('nav');
        const header = document.getElementById('header');
        const content = document.getElementById('content');

        if (toggleBtn && nav) {
            function isLargeScreen() {
                return window.innerWidth >= 1024;
            }

            let isHidden = localStorage.getItem('navHidden') === 'true';

            function updateLayout() {
                if (isLargeScreen()) {
                    if (isHidden) {
                        nav.classList.add('hidden');
                        nav.classList.remove('show');
                        if (header) {
                            header.style.width = '100%';
                            header.style.left = '0';
                        }
                        if (content) content.style.marginLeft = '0';
                    } else {
                        nav.classList.remove('hidden');
                        nav.classList.remove('show');
                        if (header) {
                            header.style.width = 'calc(100% - 260px)';
                            header.style.left = '260px';
                        }
                        if (content) content.style.marginLeft = '260px';
                    }
                } else {
                    if (header) {
                        header.style.width = '100%';
                        header.style.left = '0';
                    }
                    if (content) content.style.marginLeft = '0';
                    nav.classList.add('hidden');
                    nav.classList.remove('show');
                }
            }

            toggleBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (isLargeScreen()) {
                    isHidden = !isHidden;
                    localStorage.setItem('navHidden', isHidden);
                    updateLayout();
                } else {
                    nav.classList.remove('hidden');
                    nav.classList.add('show');
                }
            });

            document.addEventListener('click', () => {
                if (!isLargeScreen()) {
                    nav.classList.remove('show');
                    nav.classList.add('hidden');
                }
            });

            nav.addEventListener('click', (e) => {
                e.stopPropagation();
            });

            updateLayout();
            window.addEventListener('resize', updateLayout);
        }
    </script>
</body>
</html>