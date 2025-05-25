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

                  /* header {
                    width: 100%;
                    left: 0;
                  } */

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
            <div class ="flex h-[100vh]">
              <jsp:include page="../layout/header.jsp" />
              <jsp:include page="../layout/navbar.jsp" />
              <!-- <div id="content" class="">
                
              </div> -->
              <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
                <main>
                    <div class="container mx-auto p-4">
                        <h1 class="text-3xl font-bold text-orange-500 mb-4">Quản lí sản phẩm</h1>
                        <nav class="text-sm mb-6">
                            <ol class="list-reset flex text-gray-700">
                                <li><a href="/admin/dashboard" class="text-blue-500 hover:underline">Tổng quan</a></li>
                                <li><span class="mx-2">/</span></li>
                                <li class="text-gray-500">Sản phẩm</li>
                            </ol>
                        </nav>
        
                        <div class="mt-8">
                            <div class="flex flex-col md:flex-row md:justify-between items-center mb-4">
                                <h3 class="text-xl font-semibold mb-2 md:mb-0">Bảng sản phẩm</h3>
                                <a href="/admin/product/create" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Tạo mới sản phẩm</a>
                            </div>
                            <hr class="mb-4 border-gray-300">
        
                            <div class="overflow-x-auto">
                                <table class="min-w-full bg-white shadow rounded-lg overflow-hidden">
                                    <thead class="bg-gray-100">
                                        <tr>
                                            <th class="py-2 px-4 text-left">ID</th>
                                            <th class="py-2 px-4 text-left">Tên</th>
                                            <th class="py-2 px-4 text-left">Giá</th>
                                            <th class="py-2 px-4 text-left">Số lượng kho</th>
                                            <th class="py-2 px-4 text-left">Hãng</th>
                                            <th class="py-2 px-4 text-left">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <c:forEach var="product" items="${products}">
                                        <tr class="border-t">
                                            <td class="py-2 px-4">${product.id}</td>
                                            <td class="py-2 px-4">
                                              ${product.name}
                                            </td>
                                            <td class="py-2 px-4">${product.price}</td>
                                            <td class="py-2 px-4">${product.stockQuantity}</td>
                                            <td class="py-2 px-4">
                                                <c:out value="${product.brand.name}" default="Unknown"/>
                                            </td>
                                            <td class="py-2 px-4 space-x-2 flex items-center justify-between w-[100px]">
                                                <a href="/admin/product/${product.id}" class=" text-white px-3 py-1 rounded">
                                                    <svg class="w-[20px] h-[20px] hover:fill-blue-700 duration-100" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M288 32c-80.8 0-145.5 36.8-192.6 80.6C48.6 156 17.3 208 2.5 243.7c-3.3 7.9-3.3 16.7 0 24.6C17.3 304 48.6 356 95.4 399.4C142.5 443.2 207.2 480 288 480s145.5-36.8 192.6-80.6c46.8-43.5 78.1-95.4 93-131.1c3.3-7.9 3.3-16.7 0-24.6c-14.9-35.7-46.2-87.7-93-131.1C433.5 68.8 368.8 32 288 32zM144 256a144 144 0 1 1 288 0 144 144 0 1 1 -288 0zm144-64c0 35.3-28.7 64-64 64c-7.1 0-13.9-1.2-20.3-3.3c-5.5-1.8-11.9 1.6-11.7 7.4c.3 6.9 1.3 13.8 3.2 20.7c13.7 51.2 66.4 81.6 117.6 67.9s81.6-66.4 67.9-117.6c-11.1-41.5-47.8-69.4-88.6-71.1c-5.8-.2-9.2 6.1-7.4 11.7c2.1 6.4 3.3 13.2 3.3 20.3z"/></svg>
                                                </a>
                                                <a href="/admin/product/update/${product.id}" class="text-white px-3 py-1 rounded">
                                                  <svg class="w-[20px] h-[20px] hover:fill-yellow-800 duration-100" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M352 320c88.4 0 160-71.6 160-160c0-15.3-2.2-30.1-6.2-44.2c-3.1-10.8-16.4-13.2-24.3-5.3l-76.8 76.8c-3 3-7.1 4.7-11.3 4.7L336 192c-8.8 0-16-7.2-16-16l0-57.4c0-4.2 1.7-8.3 4.7-11.3l76.8-76.8c7.9-7.9 5.4-21.2-5.3-24.3C382.1 2.2 367.3 0 352 0C263.6 0 192 71.6 192 160c0 19.1 3.4 37.5 9.5 54.5L19.9 396.1C7.2 408.8 0 426.1 0 444.1C0 481.6 30.4 512 67.9 512c18 0 35.3-7.2 48-19.9L297.5 310.5c17 6.2 35.4 9.5 54.5 9.5zM80 408a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/></svg>
                                                </a>
                                                <a href="/admin/product/delete/${product.id}" class="text-white px-3 py-1 rounded">
                                                    <svg class="w-[20px] h-[20px] hover:fill-red-700 duration-100" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M135.2 17.7L128 32 32 32C14.3 32 0 46.3 0 64S14.3 96 32 96l384 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-96 0-7.2-14.3C307.4 6.8 296.3 0 284.2 0L163.8 0c-12.1 0-23.2 6.8-28.6 17.7zM416 128L32 128 53.2 467c1.6 25.3 22.6 45 47.9 45l245.8 0c25.3 0 46.3-19.7 47.9-45L416 128z"/></svg>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
        
                            <!-- Pagination -->
                            <!-- <nav class="flex justify-center mt-8">
                                <ul class="inline-flex items-center -space-x-px">
                                    <li>
                                        <a href="/admin/product?page=${currentPage-1}" 
                                            class="px-3 py-2 ml-0 leading-tight ${currentPage eq 1 ? 'pointer-events-none text-gray-400' : 'text-blue-500 hover:bg-gray-200'} border border-gray-300 rounded-l-lg">
                                            &laquo;
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                        <li>
                                            <a href="/admin/product?page=${loop.index}" 
                                                class="px-3 py-2 leading-tight ${loop.index eq currentPage ? 'bg-blue-500 text-white' : 'text-blue-500 hover:bg-gray-200'} border border-gray-300">
                                                ${loop.index}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <li>
                                        <a href="/admin/product?page=${currentPage+1}" 
                                            class="px-3 py-2 leading-tight ${currentPage eq totalPages ? 'pointer-events-none text-gray-400' : 'text-blue-500 hover:bg-gray-200'} border border-gray-300 rounded-r-lg">
                                            &raquo;
                                        </a>
                                    </li>
                                </ul>
                            </nav> -->
        
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
        </body>
        </html>

        