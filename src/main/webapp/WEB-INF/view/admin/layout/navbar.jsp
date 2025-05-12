<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<nav class = "w-[260px] h-full bg-[#fff] border-r-2 fixed">
    <h1 class ="h-[60px] text-center leading-[60px] text-[30px] font-bold text-[#79CDCD] drop-shadow-xl">ShopPhone</h1>
    <ul class="h-[240px]">
        <li class ="">
            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10  " href ="/admin/dashboard">
                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zm320 96c0-26.9-16.5-49.9-40-59.3L280 88c0-13.3-10.7-24-24-24s-24 10.7-24 24l0 204.7c-23.5 9.5-40 32.5-40 59.3c0 35.3 28.7 64 64 64s64-28.7 64-64zM144 176a32 32 0 1 0 0-64 32 32 0 1 0 0 64zm-16 80a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zm288 32a32 32 0 1 0 0-64 32 32 0 1 0 0 64zM400 144a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"/></svg>
                <p>Thống kê</p>
            </a>
        </li>
        <li>
            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/user">
                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z"/></svg>
                <p >Người dùng</p>
            </a>
        </li>
        <li >
            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/product">
                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M160 265.2c0 8.5-3.4 16.6-9.4 22.6l-26.8 26.8c-12.3 12.3-32.5 11.4-49.4 7.2C69.8 320.6 65 320 60 320c-33.1 0-60 26.9-60 60s26.9 60 60 60c6.3 0 12 5.7 12 12c0 33.1 26.9 60 60 60s60-26.9 60-60c0-5-.6-9.8-1.8-14.5c-4.2-16.9-5.2-37.1 7.2-49.4l26.8-26.8c6-6 14.1-9.4 22.6-9.4l89.2 0c6.3 0 12.4-.3 18.5-1c11.9-1.2 16.4-15.5 10.8-26c-8.5-15.8-13.3-33.8-13.3-53c0-61.9 50.1-112 112-112c8 0 15.7 .8 23.2 2.4c11.7 2.5 24.1-5.9 22-17.6C494.5 62.5 422.5 0 336 0C238.8 0 160 78.8 160 176l0 89.2z"/></svg>
                <p >Sản phẩm</p>
            </a>
        </li>
        <li>
            <div id="dropdownShowOrder" class =" relative flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/order">
                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M48 0C21.5 0 0 21.5 0 48L0 368c0 26.5 21.5 48 48 48l16 0c0 53 43 96 96 96s96-43 96-96l128 0c0 53 43 96 96 96s96-43 96-96l32 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l0-64 0-32 0-18.7c0-17-6.7-33.3-18.7-45.3L512 114.7c-12-12-28.3-18.7-45.3-18.7L416 96l0-48c0-26.5-21.5-48-48-48L48 0zM416 160l50.7 0L544 237.3l0 18.7-128 0 0-96zM112 416a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm368-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>
                <p >Đơn hàng</p> 
                <div id="dropdownOrder" class=" h-[200px] font-[600] text-[16px] absolute bottom-[-200px] right-0 z-10 mt-2 w-[260px] bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none hidden">
                    <div class="py-1">
                      <ul>
                        <li class="hover:bg-[#1890FF]/20">
                          <a href ="/admin/order/all" class=" block px-4 py-2 text-sm text-gray-700">Tất cả đơn hàng</a>
                        </li>
                        <li class="hover:bg-[#1890FF]/20">
                          <a href ="/admin/order/unconfirmed" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng chưa xác nhận</a>
                        </li>
                        <li class="hover:bg-[#1890FF]/20">
                          <a href ="/admin/order/comfirmed" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã xác nhận</a>
                        </li>
                        <li class="hover:bg-[#1890FF]/20">
                          <a href ="/admin/order/processed" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã xử lí</a>
                        </li>
                        <li class="hover:bg-[#1890FF]/20">
                          <a href ="/admin/order/complete" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã hoàn thành</a>
                        </li>
                      </ul>
                    </div>
                </div>
            </div>           
        </li>
    </ul>
</nav>