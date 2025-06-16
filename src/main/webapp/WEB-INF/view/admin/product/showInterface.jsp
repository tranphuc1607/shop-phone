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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>Admin-Product</title>
    <style>
        * {
            cursor: pointer;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-hover {
            transition: all 0.3s ease;
            transform: translateY(0);
        }

        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .action-btn {
            transition: all 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        .table-row {
            transition: all 0.3s ease;
        }

        .table-row:hover {
            background: linear-gradient(90deg, rgba(59, 130, 246, 0.1), rgba(147, 51, 234, 0.1));
            transform: scale(1.01);
        }

        .gradient-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .floating-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .pagination-btn {
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .pagination-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.6s ease-out;
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
                display: none;
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
    </style>
</head>
<body>
    <div class="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        
        <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
            <main class="animate-fade-in-up">
                <div class="container mx-auto p-6">
                    <!-- Header Section -->
                    <div class="mb-8">
                        <h1 class="text-4xl text-white font-bold mb-4 flex items-center">
                            <i class="fas fa-box mr-4 text-white"></i>
                            Quản lí sản phẩm
                        </h1>

                        <nav class="text-sm mb-6">
                            <ol class="flex items-center space-x-2 text-gray-600">
                                <li><a href="/admin/dashboard" class="hover:text-blue-500 transition-colors duration-200 flex items-center">
                                    <i class="fas fa-home mr-1"></i>Tổng quan
                                </a></li>
                                <li><i class="fas fa-chevron-right text-gray-400"></i></li>
                                <li class="text-gray-800 font-medium">Sản phẩm</li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Main Content Card -->
                    <div class="floating-card rounded-2xl p-8 card-hover">
                        <div class="flex flex-col lg:flex-row lg:justify-between lg:items-center mb-6">
                            <h3 class="text-2xl font-bold text-gray-800 mb-4 lg:mb-0 flex items-center">
                                <i class="fas fa-table mr-3 text-purple-500"></i>
                                Bảng sản phẩm
                            </h3>
                            <a href="/admin/product/create" 
                               class="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold py-3 px-6 rounded-lg shadow-lg hover:shadow-xl transition-all duration-300 flex items-center action-btn">
                                <i class="fas fa-plus mr-2"></i>
                                Tạo mới sản phẩm
                            </a>
                        </div>
                        
                        <div class="h-1 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full mb-6"></div>

                        <!-- Table Container -->
                        <div class="overflow-x-auto">
                            <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
                                <thead class="bg-gradient-to-r from-gray-50 to-gray-100">
                                    <tr>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-hashtag mr-2 text-blue-500"></i>ID
                                        </th>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-tag mr-2 text-green-500"></i>Tên sản phẩm
                                        </th>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-dollar-sign mr-2 text-purple-500"></i>Giá bán
                                        </th>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-warehouse mr-2 text-orange-500"></i>Tồn kho
                                        </th>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-trademark mr-2 text-indigo-500"></i>Thương hiệu
                                        </th>
                                        <th class="py-4 px-6 text-left text-sm font-bold text-gray-700 uppercase tracking-wider">
                                            <i class="fas fa-cogs mr-2 text-red-500"></i>Thao tác
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach var="product" items="${products}">
                                        <tr class="table-row">
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                    #${product.id}
                                                </span>
                                            </td>
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="flex-shrink-0 h-8 w-8">
                                                        <div class="h-8 w-8 rounded-full bg-gradient-to-r from-green-400 to-blue-500 flex items-center justify-center">
                                                            <span class="text-white text-sm font-medium">
                                                                ${product.name.substring(0,1).toUpperCase()}
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="ml-3">
                                                        <div class="text-sm font-medium text-gray-900">${product.name}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                    <i class="fas fa-circle mr-1 text-xs"></i>
                                                    ${product.price} VNĐ
                                                </span>
                                            </td>
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-2 h-2 bg-emerald-400 rounded-full mr-2"></div>
                                                    <span class="text-sm text-gray-900 font-medium">${product.stockQuantity}</span>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                                                    <i class="fas fa-circle mr-1 text-xs"></i>
                                                    <c:out value="${product.brand.name}" default="Chưa có"/>
                                                </span>
                                            </td>
                                            <td class="py-4 px-6 whitespace-nowrap">
                                                <div class="flex items-center space-x-3">
                                                    <a href="/admin/product/${product.id}" 
                                                       class="bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 action-btn"
                                                       title="Xem chi tiết">
                                                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" fill="currentColor">
                                                            <path d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z"/>
                                                        </svg>
                                                    </a>
                                                    <a href="/admin/product/update/${product.id}" 
                                                       class="bg-yellow-500 hover:bg-yellow-600 text-white p-2 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 action-btn"
                                                       title="Chỉnh sửa">
                                                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="currentColor">
                                                            <path d="M352 320c88.4 0 160-71.6 160-160c0-15.3-2.2-30.1-6.2-44.2c-3.1-10.8-16.4-13.2-24.3-5.3l-76.8 76.8c-3 3-7.1 4.7-11.3 4.7L336 192c-8.8 0-16-7.2-16-16l0-57.4c0-4.2 1.7-8.3 4.7-11.3l76.8-76.8c7.9-7.9 5.4-21.2-5.3-24.3C382.1 2.2 367.3 0 352 0C263.6 0 192 71.6 192 160c0 19.1 3.4 37.5 9.5 54.5L19.9 396.1C7.2 408.8 0 426.1 0 444.1C0 481.6 30.4 512 67.9 512c18 0 35.3-7.2 48-19.9L297.5 310.5c17 6.2 35.4 9.5 54.5 9.5zM80 408a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/>
                                                        </svg>
                                                    </a>
                                                    <a href="#" 
                                                       class="bg-red-500 hover:bg-red-600 text-white p-2 rounded-lg shadow-md hover:shadow-lg transition-all duration-200 action-btn delete-btn"
                                                       data-user-id="${product.id}"
                                                       data-user-name="${product.name}"
                                                       title="Xóa">
                                                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" fill="currentColor">
                                                            <path d="M135.2 17.7L128 32 32 32C14.3 32 0 46.3 0 64S14.3 96 32 96l384 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-96 0-7.2-14.3C307.4 6.8 296.3 0 284.2 0L163.8 0c-12.1 0-23.2 6.8-28.6 17.7zM416 128L32 128 53.2 467c1.6 25.3 22.6 45 47.9 45l245.8 0c25.3 0 46.3-19.7 47.9-45L416 128z"/>
                                                        </svg>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <div class="mt-8">
                            <div class="flex justify-center items-center space-x-2">
                                <c:choose>
                                    <c:when test="${totalPages <= 7}">
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <a href="?page=${i}&size=${size}"
                                               class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                      ${i == currentPage ? 'bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="?page=1&size=${size}"
                                           class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                  ${currentPage == 1 ? 'bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">1</a>

                                        <c:if test="${currentPage > 4}">
                                            <span class="px-3 py-2 text-gray-500">...</span>
                                        </c:if>

                                        <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}">
                                            <c:if test="${i > 1 && i < totalPages}">
                                                <a href="?page=${i}&size=${size}"
                                                   class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                          ${i == currentPage ? 'bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                                    ${i}
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages - 3}">
                                            <span class="px-3 py-2 text-gray-500">...</span>
                                        </c:if>

                                        <a href="?page=${totalPages}&size=${size}"
                                           class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                  ${currentPage == totalPages ? 'bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                            ${totalPages}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        const dropdownButton = document.getElementById('dropdown');
        const dropdownMenu = document.getElementById('dropdownMenu');

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

        const dropdownShowOrder = document.getElementById('dropdownShowOrder');
        const dropdownOrder = document.getElementById('dropdownOrder');

        let timer2;
        dropdownShowOrder.addEventListener('click', function() {
            if (dropdownOrder.classList.contains('hidden')) {
                dropdownOrder.classList.remove('hidden');
                timer2 = setTimeout(() => {
                    dropdownOrder.classList.add('opacity-0');
                }, 10000);
            } else {
                dropdownOrder.classList.add('hidden');
                dropdownOrder.classList.remove('opacity-0');
                clearTimeout(timer2);
            }
        });

        window.addEventListener('click', function(event) {
            if (!dropdownShowOrder.contains(event.target) && !dropdownOrder.contains(event.target)) {
                dropdownOrder.classList.add('hidden');
                dropdownOrder.classList.remove('opacity-0');
                clearTimeout(timer2);
            }
        });

        const toggleBtn = document.getElementById('icon--list');
        const nav = document.querySelector('nav');
        const header = document.getElementById('header');
        const content = document.getElementById('content');

        function isLargeScreen() {
            return window.innerWidth >= 1024;
        }

        let isHidden = localStorage.getItem('navHidden') === 'true';

        function updateLayout() {
            if (isLargeScreen()) {
                if (isHidden) {
                    nav.classList.add('hidden');
                    nav.classList.remove('show');
                    header.style.width = '100%';
                    header.style.left = '0';
                    content.style.marginLeft = '0';
                } else {
                    nav.classList.remove('hidden');
                    nav.classList.remove('show');
                    header.style.width = 'calc(100% - 260px)';
                    header.style.left = '260px';
                    content.style.marginLeft = '260px';
                }
            } else {
                header.style.width = '100%';
                header.style.left = '0';
                content.style.marginLeft = '0';
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
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const userId = this.getAttribute('data-user-id');
                    const userName = this.getAttribute('data-user-name');

                    console.log("Bạn đang xóa:", userName);

                    Swal.fire({
                        title: 'Bạn có chắc chắn?',
                        text: "Bạn muốn xóa sản phẩm " + userName + "? Hành động này không thể hoàn tác!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#d33',
                        cancelButtonColor: '#3085d6',
                        confirmButtonText: 'Xóa',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/admin/product/delete/" + userId
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>