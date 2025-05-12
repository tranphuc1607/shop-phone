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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Document</title>
</head>
<body>
    <div class ="bg-[#fff]">
        <jsp:include page="../layout/layout.jsp" />
        <div>
            <image class ="lg:mt-[40px] md:mt-[40px] mx:mt-[20px] mt-[20px] rounded-[20px] shadow-lg border" src = "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(100)/H1_1440x242_474025c3b6.png"></image>
        </div>
        <div class ="flex item-center justify-center mt-[60px]">
            <h1 class = "font-bold text-lg">SẢN PHẨM NÔỈ BẬT</h1>
        </div>
        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4 md:px-[100px] gap-6">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="fruite-img">
                        <img src="https://bizweb.dktcdn.net/thumb/large/100/383/803/products/13-ccbad032-7c86-4434-9add-edd47aafa0be.jpg?v=1586770955523" alt="${product.name}"
                             class="w-full h-44 object-cover rounded-t-lg">
                    </div>
        
                    <div class="p-4">
                        <h4 class="text-sm font-semibold text-gray-800 mb-2 flex justify-center ">
                            <a href="/product/${product.id}" class=" no-underline text-[#000]-600 ">Iphone 16 Pro Max</a>
                        </h4>
                        <div class="flex flex-col justify-center items-center">
                            <p class="text-lg text-red-500 font-bold mb-3">
                                <fmt:formatNumber type="number" value="${product.price}" /> 1.000.000 VND
                            </p>
                            <form class="flex" method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit"
                                        class="btn border border-gray-300 rounded-full px-4 py-2 text-primary hover:bg-gray-100 transition">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="fruite-img">
                        <img src="https://bizweb.dktcdn.net/thumb/large/100/383/803/products/13-ccbad032-7c86-4434-9add-edd47aafa0be.jpg?v=1586770955523" alt="${product.name}"
                             class="w-full h-44 object-cover rounded-t-lg">
                    </div>
        
                    <div class="p-4">
                        <h4 class="text-sm font-semibold text-gray-800 mb-2 flex justify-center ">
                            <a href="/product/${product.id}" class=" no-underline text-[#000]-600 ">Iphone 16 Pro Max</a>
                        </h4>
                        <div class="flex flex-col justify-center items-center">
                            <p class="text-lg text-red-500 font-bold mb-3">
                                <fmt:formatNumber type="number" value="${product.price}" /> 1.000.000 VND
                            </p>
                            <form class="flex" method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit"
                                        class="btn border border-gray-300 rounded-full px-4 py-2 text-primary hover:bg-gray-100 transition">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="fruite-img">
                        <img src="https://bizweb.dktcdn.net/thumb/large/100/383/803/products/13-ccbad032-7c86-4434-9add-edd47aafa0be.jpg?v=1586770955523" alt="${product.name}"
                             class="w-full h-44 object-cover rounded-t-lg">
                    </div>
        
                    <div class="p-4">
                        <h4 class="text-sm font-semibold text-gray-800 mb-2 flex justify-center ">
                            <a href="/product/${product.id}" class=" no-underline text-[#000]-600 ">Iphone 16 Pro Max</a>
                        </h4>
                        <div class="flex flex-col justify-center items-center">
                            <p class="text-lg text-red-500 font-bold mb-3">
                                <fmt:formatNumber type="number" value="${product.price}" /> 1.000.000 VND
                            </p>
                            <form class="flex" method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit"
                                        class="btn border border-gray-300 rounded-full px-4 py-2 text-primary hover:bg-gray-100 transition">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="fruite-img">
                        <img src="https://bizweb.dktcdn.net/thumb/large/100/383/803/products/13-ccbad032-7c86-4434-9add-edd47aafa0be.jpg?v=1586770955523" alt="${product.name}"
                             class="w-full h-44 object-cover rounded-t-lg">
                    </div>
        
                    <div class="p-4">
                        <h4 class="text-sm font-semibold text-gray-800 mb-2 flex justify-center ">
                            <a href="/product/${product.id}" class=" no-underline text-[#000]-600 ">Iphone 16 Pro Max</a>
                        </h4>
                        <div class="flex flex-col justify-center items-center">
                            <p class="text-lg text-red-500 font-bold mb-3">
                                <fmt:formatNumber type="number" value="${product.price}" /> 1.000.000 VND
                            </p>
                            <form class="flex" method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit"
                                        class="btn border border-gray-300 rounded-full px-4 py-2 text-primary hover:bg-gray-100 transition">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
        <div class="w-[80%] m-auto h-px bg-black mt-[20px]"></div>
        <div class="overflow-hidden w-[80%] m-auto mt-[20px]">
            <img
              src="https://bizweb.dktcdn.net/100/384/782/themes/764040/assets/slider_2.jpg?1617347076987"
              alt="Ảnh demo"
              class="w-full h-auto transition-transform duration-300 hover:scale-105 rounded "
            />
        </div>
        <div class="w-[80%] m-auto h-px bg-black mt-[20px]"></div>
        <h1 class ="text-center mt-[20px] text-gray-700 font-bold text-lg">DANH SÁCH SẢN PHẨM</h1>
        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6 mt-[20px] md:px-[100px]">
            <c:forEach var="product" items="${products}">
                    <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="fruite-img">
                        <img src="/images/${product.image}" alt="lỗi ảnh"
                             class="w-full h-44 object-cover rounded-t-lg">
                    </div>
                
                    <div class="p-4">
                        <h4 class="text-sm font-semibold text-gray-800 mb-2 flex justify-center ">
                            <a href="/product/detail" class=" no-underline text-[#000]-600 ">${product.name}</a>
                        </h4>
                        <div class="flex flex-col justify-center items-center">
                            <p class="text-lg text-red-500 font-bold mb-3">
                                <fmt:formatNumber type="number" value="${product.price}" /> 
                            </p>
                            <form class="flex" method="post" action="/add-product-to-cart/${product.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit"
                                        class="btn border border-gray-300 rounded-full px-4 py-2 text-primary hover:bg-gray-100 transition">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class = "flex justify-center">
            <button class="relative inline-block px-6 py-2 rounded-full border border-black overflow-hidden group transition-all duration-700 mt-[20px]">
                <span class="absolute inset-0 bg-gradient-to-r from-blue-500 to-purple-500 translate-x-[-100%] group-hover:translate-x-0 transition-transform duration-700 ease-in-out"></span>
                <span class="relative text-black group-hover:text-white transition-colors duration-700">
                  Xem thêm
                </span>
            </button>
        </div>
        <svg id ="arrow-top" class ="w-[70px] h-[40px] mt-[12px] cursor-pointer fixed right-[20px] bottom-[20px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M214.6 41.4c-12.5-12.5-32.8-12.5-45.3 0l-160 160c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L160 141.2 160 448c0 17.7 14.3 32 32 32s32-14.3 32-32l0-306.7L329.4 246.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-160-160z"/></svg>
    </div>
</body>
<script>
    const arrowTopButton = document.getElementById('arrow-top');

    window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
        arrowTopButton.classList.remove('hidden');
    } else {
        arrowTopButton.classList.add('hidden');
    }
    });

    arrowTopButton.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
    });
</script>
</html>