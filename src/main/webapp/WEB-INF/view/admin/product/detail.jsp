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
            <title>Admin-User</title>
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

            </style>
        </head>

<body class="bg-gray-100">
    <div class ="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
            <div class="bg-white p-6 rounded-lg shadow-md">
            <h1 class="text-3xl font-bold text-gray-800 mb-6">Chi tiết sản phẩm</h1>

            <!-- Product Info Section -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Product Image -->
                <div class="flex justify-center">
                    <img src="/images/${product.image}" alt="Product Image" class="max-w-full h-auto rounded-lg shadow-md">
                </div>

                <!-- Product Information -->
                <div>
                    <div class="mb-4">
                        <label for="productName" class="block text-lg font-medium text-gray-700">Tên sản phẩm</label>
                        <input type="text" id="productName" value="${product.name}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productDescription" class="block text-lg font-medium text-gray-700">Mô tả</label>
                        <textarea id="productDescription" class="w-full p-3 border border-gray-300 rounded-lg mt-1" rows="4" disabled>${product.description}</textarea>
                    </div>
                    <div class="mb-4">
                        <label for="productPrice" class="block text-lg font-medium text-gray-700">Giá</label>
                        <input type="text" id="productPrice" value="${product.price}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productStock" class="block text-lg font-medium text-gray-700">Số lượng kho</label>
                        <input type="number" id="productStock" value="${product.stockQuantity}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productBrand" class="block text-lg font-medium text-gray-700">Hãng</label>
                        <input type="text" id="productBrand" value="${product.brand.name}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                </div>
            </div>

            <!-- Product Specifications -->
            <div class="mt-8">
                <h2 class="text-2xl font-semibold text-gray-800 mb-3">Đặc điểm sản phẩm</h2>
                <ul class="list-disc pl-6 space-y-2">
                    <li><strong>Màn hình:</strong> <c:out value="${product.specification.screen}" /></li>
                    <li><strong>RAM:</strong> <c:out value="${product.specification.ram}" /></li>
                    <li><strong>Bộ nhớ:</strong> <c:out value="${product.specification.storage}" /></li>
                    <li><strong>Pin:</strong> <c:out value="${product.specification.battery}" /></li>
                    <li><strong>Hệ điều hành:</strong> <c:out value="${product.specification.os}" /></li>
                    <li><strong>Chipset:</strong> <c:out value="${product.specification.chipset}" /></li>
                </ul>
            </div>

            <a style="width:400px;" href="/admin/product" class="mt-6 mx-[75vh] bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">Quay lại</a>
        </div>

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
</body>

</html>
