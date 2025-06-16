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
                
                /* Animations */
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
                
                @keyframes slideInLeft {
                    from {
                        opacity: 0;
                        transform: translateX(-30px);
                    }
                    to {
                        opacity: 1;
                        transform: translateX(0);
                    }
                }
                
                @keyframes slideInRight {
                    from {
                        opacity: 0;
                        transform: translateX(30px);
                    }
                    to {
                        opacity: 1;
                        transform: translateX(0);
                    }
                }
                
                @keyframes shimmer {
                    0% {
                        background-position: -200px 0;
                    }
                    100% {
                        background-position: calc(200px + 100%) 0;
                    }
                }
                
                .animate-fade-in-up {
                    animation: fadeInUp 0.8s ease-out;
                }
                
                .animate-slide-in-left {
                    animation: slideInLeft 0.8s ease-out 0.2s both;
                }
                
                .animate-slide-in-right {
                    animation: slideInRight 0.8s ease-out 0.4s both;
                }
                
                .glass-effect {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                }
                
                .shimmer {
                    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
                    background-size: 200px 100%;
                    animation: shimmer 2s infinite;
                }
                
                .gradient-bg {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                }
                
                .card-hover {
                    transition: all 0.3s ease;
                }
                
                .card-hover:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                }
                
                .spec-item {
                    transition: all 0.3s ease;
                    position: relative;
                    overflow: hidden;
                }
                
                .spec-item::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
                    transition: left 0.5s;
                }
                
                .spec-item:hover::before {
                    left: 100%;
                }
                
                .spec-item:hover {
                    background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
                    transform: translateX(10px);
                }
                
                .image-container {
                    position: relative;
                    overflow: hidden;
                    border-radius: 1rem;
                }
                
                .image-container::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(45deg, transparent 49%, rgba(255, 255, 255, 0.3) 50%, transparent 51%);
                    opacity: 0;
                    transition: opacity 0.3s;
                    z-index: 1;
                }
                
                .image-container:hover::before {
                    opacity: 1;
                }
                
                .floating-button {
                    position: relative;
                    overflow: hidden;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    transition: all 0.3s ease;
                }
                
                .floating-button::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
                    transition: left 0.5s;
                }
                
                .floating-button:hover::before {
                    left: 100%;
                }
                
                .floating-button:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
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

<body class="gradient-bg min-h-screen">
    <div class ="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        <div id="content" style ="z-index: -10;" class="flex-1 pt-[80px] px-[20px] w-full ml-[260px]">
            <div class="glass-effect p-8 rounded-2xl shadow-2xl card-hover animate-fade-in-up">
                <div class="flex items-center justify-between mb-8">
                    <h1 class="text-4xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">
                        Chi tiết sản phẩm
                    </h1>
                    <div class="w-16 h-1 bg-gradient-to-r from-purple-600 to-blue-600 rounded-full"></div>
                </div>

                <!-- Product Info Section -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <!-- Product Image -->
                    <div class="animate-slide-in-left">
                        <div class="image-container bg-gradient-to-br from-gray-50 to-gray-100 p-6 rounded-2xl shadow-lg">
                            <img src="/images/${product.image}" alt="Product Image" 
                                 class="w-full h-auto rounded-xl shadow-md hover:scale-105 transition-transform duration-300">
                        </div>
                    </div>

                    <!-- Product Information -->
                    <div class="animate-slide-in-right space-y-6">
                        <div class="group">
                            <label class="block text-sm font-semibold text-gray-700 mb-2 uppercase tracking-wide">
                                🏷️ Tên sản phẩm
                            </label>
                            <div class="relative">
                                <input type="text" value="${product.name}" 
                                       class="w-full p-4 bg-white border-2 border-gray-200 rounded-xl focus:border-purple-500 focus:ring-2 focus:ring-purple-200 transition-all duration-300 font-medium text-gray-800" 
                                       disabled>
                                <div class="absolute inset-y-0 right-0 flex items-center pr-4">
                                    <div class="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="group">
                            <label class="block text-sm font-semibold text-gray-700 mb-2 uppercase tracking-wide">
                                📝 Mô tả
                            </label>
                            <textarea class="w-full p-4 bg-white border-2 border-gray-200 rounded-xl focus:border-purple-500 focus:ring-2 focus:ring-purple-200 transition-all duration-300 resize-none" 
                                      rows="4" disabled>${product.description}</textarea>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="group">
                                <label class="block text-sm font-semibold text-gray-700 mb-2 uppercase tracking-wide">
                                    💰 Giá
                                </label>
                                <input type="text" value="${product.price}" 
                                       class="w-full p-4 bg-gradient-to-r from-green-50 to-emerald-50 border-2 border-green-200 rounded-xl font-bold text-green-800 text-lg" 
                                       disabled>
                            </div>
                            
                            <div class="group">
                                <label class="block text-sm font-semibold text-gray-700 mb-2 uppercase tracking-wide">
                                    📦 Số lượng kho
                                </label>
                                <input type="number" value="${product.stockQuantity}" 
                                       class="w-full p-4 bg-gradient-to-r from-blue-50 to-cyan-50 border-2 border-blue-200 rounded-xl font-bold text-blue-800 text-lg" 
                                       disabled>
                            </div>
                        </div>
                        
                        <div class="group">
                            <label class="block text-sm font-semibold text-gray-700 mb-2 uppercase tracking-wide">
                                🏭 Hãng
                            </label>
                            <input type="text" value="${product.brand.name}" 
                                   class="w-full p-4 bg-gradient-to-r from-purple-50 to-pink-50 border-2 border-purple-200 rounded-xl font-bold text-purple-800 text-lg" 
                                   disabled>
                        </div>
                    </div>
                </div>

                <!-- Product Specifications -->
                <div class="bg-gradient-to-br from-gray-50 to-white p-6 rounded-2xl shadow-lg animate-fade-in-up">
                    <div class="flex items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-800">⚙️ Đặc điểm sản phẩm</h2>
                        <div class="ml-4 flex-1 h-0.5 bg-gradient-to-r from-purple-500 to-transparent"></div>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">🖥️</span>
                                <div>
                                    <strong class="text-gray-700">Màn hình:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.screen}" /></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">🧠</span>
                                <div>
                                    <strong class="text-gray-700">RAM:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.ram}" /></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">💾</span>
                                <div>
                                    <strong class="text-gray-700">Bộ nhớ:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.storage}" /></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">🔋</span>
                                <div>
                                    <strong class="text-gray-700">Pin:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.battery}" /></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">🖥️</span>
                                <div>
                                    <strong class="text-gray-700">Hệ điều hành:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.os}" /></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-item bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                            <div class="flex items-center">
                                <span class="text-2xl mr-3">⚡</span>
                                <div>
                                    <strong class="text-gray-700">Chipset:</strong>
                                    <p class="text-gray-600 font-medium"><c:out value="${product.specification.chipset}" /></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Back Button -->
                <div class="flex justify-center mt-8">
                    <a href="/admin/product" 
                       class="floating-button text-white px-8 py-4 rounded-full font-semibold text-lg shadow-lg hover:shadow-xl transition-all duration-300 flex items-center space-x-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                        </svg>
                        <span>Quay lại danh sách</span>
                    </a>
                </div>
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