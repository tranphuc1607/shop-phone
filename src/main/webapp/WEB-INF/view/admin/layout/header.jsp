<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <div id="header" style="width :calc(100% - 260px)" class ="px-[15px] bg-[#fff] flex justify-between items-center h-[60px] border-b-2 fixed top-0">
            <svg id="icon--list" class="w-[20px] h-[20px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.<path d="M64 144a48 48 0 1 0 0-96 48 48 0 1 0 0 96zM192 64c-17.7 0-32 14.3-32 32s14.3 32 32 32l288 0c17.7 0 32-14.3 32-32s-14.3-32-32-32L192 64zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32l288 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-288 0zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32l288 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-288 0zM64 464a48 48 0 1 0 0-96 48 48 0 1 0 0 96zm48-208a48 48 0 1 0 -96 0 48 48 0 1 0 96 0z"/></svg>
            <div id="dropdown" class ="relative flex justify-between items-center w-[180px] px-[10px]">
                <div class="rounded-full bg-[#000] h-[40px] w-[40px]"></div>
                <h3 class="text-center leading-[60px]">Tên đăng nhập</h3>
                <div id="dropdownMenu" class="absolute top-[60px] right-0 z-10 mt-2 w-48 bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none hidden">
                    <div class="py-1">
                      <ul>
                        <li>
                          <p class="block px-4 py-2 text-sm text-gray-700">Profile</p>
                        </li>
                        <li>
                          <p class="block px-4 py-2 text-sm text-gray-700">Update Profile</p>
                        </li>
                        <li>
                          <p class="block px-4 py-2 text-sm text-gray-700">Đăng xuất</p>
                        </li>
                      </ul>
                    </div>
                </div>
            </div>
        </div>  
        