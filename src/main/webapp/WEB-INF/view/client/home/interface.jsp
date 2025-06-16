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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Modern Shop</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            font-family: 'Inter', sans-serif;
        }
        
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .glass-effect {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .product-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }
        
        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
            z-index: 1;
        }
        
        .product-card:hover::before {
            left: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }
        
        .floating-animation {
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .pulse-button {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(59, 130, 246, 0); }
            100% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0); }
        }
        
        .section-divider {
            height: 2px;
            background: linear-gradient(90deg, transparent, #3b82f6, transparent);
        }
        
        .price-glow {
            text-shadow: 0 0 20px rgba(239, 68, 68, 0.5);
        }
        
        .hero-banner {
            position: relative;
            overflow: hidden;
        }
        
        .hero-banner::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 50%;
            background: linear-gradient(to top, rgba(0,0,0,0.3), transparent);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-100 min-h-screen">
    <div class="relative">
        <jsp:include page="../layout/layout.jsp" />
        
        <!-- Hero Banner Section -->
        <div class="relative mx-4 lg:mx-8 mt-8">
            <div class="hero-banner rounded-3xl overflow-hidden shadow-2xl">
                <img class="w-full h-48 md:h-64 lg:h-80 object-cover transform hover:scale-105 transition-transform duration-700" 
                     src="https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(100)/H1_1440x242_474025c3b6.png" 
                     alt="Hero Banner">
                <div class="absolute inset-0 bg-gradient-to-r from-purple-600/20 to-blue-600/20"></div>
            </div>
        </div>

        <!-- Featured Products Section -->
        <div class="container mx-auto px-4 mt-16">
            <div class="text-center mb-12">
                <div class="inline-block">
                    <h1 class="text-3xl md:text-4xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent mb-4">
                        SẢN PHẨM NỔI BẬT
                    </h1>
                    <div class="w-24 h-1 bg-gradient-to-r from-purple-500 to-blue-500 mx-auto rounded-full"></div>
                </div>
            </div>
            
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4 gap-6 lg:gap-8">
                <c:forEach var="product" items="${products}">
                    <div class="product-card bg-white/80 backdrop-blur-sm rounded-2xl shadow-lg hover:shadow-2xl border border-white/50">
                        <div class="relative overflow-hidden rounded-t-2xl group">
                            <img src="/images/${product.image}" 
                                 alt="Product Image"
                                 class="w-full h-44 md:h-48 object-cover group-hover:scale-110 transition-transform duration-500">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                            <div class="absolute top-3 right-3 opacity-0 group-hover:opacity-100 transition-all duration-300">
                                <div class="w-8 h-8 bg-white/90 rounded-full flex items-center justify-center">
                                    <i class="fas fa-heart text-red-500 text-sm"></i>
                                </div>
                            </div>
                        </div>
                        
                        <div class="p-4 md:p-5">
                            <h4 class="text-sm md:text-base font-semibold text-gray-800 mb-3 text-center leading-tight hover:text-blue-600 transition-colors">
                                <a href="/product/detail" class="no-underline">${product.name}</a>
                            </h4>
                            
                            <div class="flex flex-col items-center space-y-3">
                                <p class="text-lg md:text-xl font-bold price-glow text-red-500">
                                    <fmt:formatNumber type="number" value="${product.price}" />₫
                                </p>
                                
                                <form method="post" action="product/addToCart/${product.id}" class="w-full">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" 
                                            class="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-medium py-2.5 px-4 rounded-xl transition-all duration-300 transform hover:scale-105 flex items-center justify-center space-x-2 shadow-lg">
                                        <i class="fas fa-shopping-cart text-sm"></i>
                                        <span class="text-sm">Thêm vào giỏ</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Decorative Divider -->
        <div class="container mx-auto px-4 my-16">
            <div class="section-divider rounded-full"></div>
        </div>

        <!-- Promotional Banner -->
        <div class="container mx-auto px-4 mb-16">
            <div class="relative rounded-3xl overflow-hidden shadow-2xl floating-animation">
                <img src="https://bizweb.dktcdn.net/100/384/782/themes/764040/assets/slider_2.jpg?1617347076987"
                     alt="Promotional Banner"
                     class="w-full h-48 md:h-64 object-cover hover:scale-105 transition-transform duration-700">
                <div class="absolute inset-0 bg-gradient-to-r from-indigo-600/30 to-purple-600/30"></div>
                <div class="absolute inset-0 flex items-center justify-center">
                    <div class="text-center text-white">
                        <h2 class="text-2xl md:text-3xl font-bold mb-2">Ưu Đãi Đặc Biệt</h2>
                        <p class="text-lg opacity-90">Giảm giá lên đến 50% cho tất cả sản phẩm</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- All Products Section -->
        <div class="container mx-auto px-4 mb-16">
            <div class="text-center mb-12">
                <h1 class="text-3xl md:text-4xl font-bold bg-gradient-to-r from-gray-700 to-gray-900 bg-clip-text text-transparent mb-4">
                    DANH SÁCH SẢN PHẨM
                </h1>
                <div class="w-32 h-1 bg-gradient-to-r from-gray-400 to-gray-600 mx-auto rounded-full"></div>
            </div>
            
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 lg:gap-6">
                <c:forEach var="product" items="${products}">
                    <div class="product-card bg-white/90 backdrop-blur-sm rounded-2xl shadow-md hover:shadow-xl border border-white/60">
                        <div class="relative overflow-hidden rounded-t-2xl group">
                            <img src="/images/${product.image}" 
                                 alt="Product Image"
                                 class="w-full h-40 md:h-44 object-cover group-hover:scale-110 transition-transform duration-500">
                            <div class="absolute top-2 left-2 opacity-0 group-hover:opacity-100 transition-all duration-300">
                                <span class="bg-red-500 text-white text-xs px-2 py-1 rounded-full font-medium">
                                    Hot
                                </span>
                            </div>
                        </div>
                        
                        <div class="p-3 md:p-4">
                            <h4 class="text-xs md:text-sm font-semibold text-gray-800 mb-2 text-center leading-tight line-clamp-2">
                                <a href="/product/detail" class="no-underline hover:text-blue-600 transition-colors">
                                    ${product.name}
                                </a>
                            </h4>
                            
                            <div class="flex flex-col items-center space-y-2">
                                <p class="text-base md:text-lg font-bold text-red-500">
                                    <fmt:formatNumber type="number" value="${product.price}" />₫
                                </p>
                                
                                <form method="post" action="product/addToCart/${product.id}" class="w-full">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" 
                                            class="w-full bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-600 hover:to-teal-700 text-white font-medium py-2 px-3 rounded-lg transition-all duration-300 transform hover:scale-105 flex items-center justify-center space-x-1 text-xs md:text-sm shadow-md">
                                        <i class="fas fa-cart-plus text-xs"></i>
                                        <span>Mua ngay</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Load More Button -->
        <div class="container mx-auto px-4 mb-16">
            <div class="flex justify-center">
                <c:if test="${currentPage < totalPages}">
                    <form method="get" action="">
                        <input type="hidden" name="page" value="${currentPage + 1}" />
                        <input type="hidden" name="size" value="${size}" />
                        <button type="submit" 
                                class="pulse-button bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white font-semibold px-8 py-3 rounded-full transition-all duration-300 transform hover:scale-105 shadow-lg flex items-center space-x-2">
                            <span>Xem thêm sản phẩm</span>
                            <i class="fas fa-arrow-down"></i>
                        </button>
                    </form>
                </c:if>
            </div>
        </div>

        <!-- Back to Top Button -->
        <button id="arrow-top" 
                class="fixed right-6 bottom-6 w-14 h-14 bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white rounded-full shadow-2xl transition-all duration-300 transform hover:scale-110 flex items-center justify-center opacity-0 invisible">
            <i class="fas fa-arrow-up text-lg"></i>
        </button>
    </div>

    <script>
        const arrowTopButton = document.getElementById('arrow-top');

        // Show/hide back to top button
        window.addEventListener('scroll', () => {
            if (window.scrollY > 300) {
                arrowTopButton.classList.remove('opacity-0', 'invisible');
                arrowTopButton.classList.add('opacity-100', 'visible');
            } else {
                arrowTopButton.classList.add('opacity-0', 'invisible');
                arrowTopButton.classList.remove('opacity-100', 'visible');
            }
        });

        // Smooth scroll to top
        arrowTopButton.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Add loading animation for images
        document.addEventListener('DOMContentLoaded', function() {
            const images = document.querySelectorAll('img');
            images.forEach(img => {
                img.addEventListener('load', function() {
                    this.style.opacity = '1';
                });
            });
        });

        // Add intersection observer for animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe product cards for scroll animations
        document.querySelectorAll('.product-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });
    </script>
</body>
</html>