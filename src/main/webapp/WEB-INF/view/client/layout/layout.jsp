<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <header class=" w-full h-[110px] bg-white flex lg:px-[175px] md:px-[100px] sm:px-[70px] px-[20px] justify-between items-center border-b-2">
            <a href = "/homepage" class = "text-[30px] font-bold text-[#79CDCD] drop-shadow-xl">ShopPhone</a>
            <div class ="w-[550px] h-[60px] flex md:justify-between lg:justify-between md:justify-end justify-end  item-center leading-[60px] ">
                <a class = "hidden lg:block md:block text-[#2F4F4F] font-bold hover:text-red-500" href = "/homepage">Trang chủ</a>
                <a class = "hidden lg:block md:block text-[#2F4F4F] font-bold hover:text-red-500" href = "/product">Sản phẩm</a>
                <a href = "/homepage/cart">
                    <svg class ="w-[50px] h-[30px] mt-[15px] cursor-pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M0 24C0 10.7 10.7 0 24 0L69.5 0c22 0 41.5 12.8 50.6 32l411 0c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3l-288.5 0 5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5L488 336c13.3 0 24 10.7 24 24s-10.7 24-24 24l-288.3 0c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5L24 48C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>           
                </a>
                <c:if test="${not empty currentUser}">
                    <div class="relative">
                        <button id="userMenuButton" class="flex w-[200px] h-[60px] items-center justify-center bg-white border border-gray-300 rounded-lg shadow-md hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition duration-150 ease-in-out">
                            <svg class="w-6 h-6 cursor-pointer text-gray-800" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 12c2.7 0 4.9-2.2 4.9-4.9S14.7 2.2 12 2.2 7.1 4.4 7.1 7.1 9.3 12 12 12zm0 2.4c-3.2 0-9.6 1.6-9.6 4.8v2.4h19.2v-2.4c0-3.2-6.4-4.8-9.6-4.8z"/>
                            </svg>
                            <span class="text-gray-800 font-semibold ml-2 text-center h-full leading-full">${currentUser.name}</span>
                        </button>
                        
                        <div id="userDropdownMenu" class="absolute right-0 mt-2 w-48 bg-white border rounded-lg shadow-lg hidden z-50">
                            <a href="/admin/user/update/${currentUser.id}"  class="block px-4 py-2 hover:bg-gray-100">Cập nhật tài khoản</a>
                            <a href="/account/change-password" class="block px-4 py-2 hover:bg-gray-100">Đổi mật khẩu</a>
                            <a href="/logout" class="block px-4 py-2 hover:bg-gray-100 text-red-500">Đăng xuất</a>
                        </div>
                    </div>
                    
                    </div>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const button = document.getElementById("userMenuButton");
                            const menu = document.getElementById("userDropdownMenu");
                    
                            button.addEventListener("click", function (event) {
                                event.stopPropagation(); // Ngăn sự kiện click lan ra ngoài
                                menu.classList.toggle("hidden");
                            });
                    
                            // Ẩn menu nếu click ra ngoài
                            document.addEventListener("click", function (event) {
                                if (!menu.contains(event.target)) {
                                    menu.classList.add("hidden");
                                }
                            });
                        });
                    </script>
                </c:if>
                <c:if test="${empty currentUser}">
                    <a href="/login" class="hidden lg:block md:block text-[#2F4F4F] font-bold hover:text-red-500">Login</a>
                    <a href="/register" class="hidden lg:block md:block text-[#2F4F4F] font-bold hover:text-red-500">Register</a>
                </c:if>
            </div>
        </header>
        