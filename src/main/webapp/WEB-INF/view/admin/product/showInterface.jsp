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
                        <h1 class="text-3xl font-bold text-orange-500 mb-4">MANAGE PRODUCTS</h1>
                        <nav class="text-sm mb-6">
                            <ol class="list-reset flex text-gray-700">
                                <li><a href="/admin/dashboard" class="text-blue-500 hover:underline">Dashboard</a></li>
                                <li><span class="mx-2">/</span></li>
                                <li class="text-gray-500">Product</li>
                            </ol>
                        </nav>
        
                        <div class="mt-8">
                            <div class="flex flex-col md:flex-row md:justify-between items-center mb-4">
                                <h3 class="text-xl font-semibold mb-2 md:mb-0">Table products</h3>
                                <a href="/admin/product/create" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Create new product</a>
                            </div>
                            <hr class="mb-4 border-gray-300">
        
                            <div class="overflow-x-auto">
                                <table class="min-w-full bg-white shadow rounded-lg overflow-hidden">
                                    <thead class="bg-gray-100">
                                        <tr>
                                            <th class="py-2 px-4 text-left">ID</th>
                                            <th class="py-2 px-4 text-left">Name</th>
                                            <th class="py-2 px-4 text-left">Price</th>
                                            <th class="py-2 px-4 text-left">StockQuantity</th>
                                            <th class="py-2 px-4 text-left">Brand</th>
                                            <th class="py-2 px-4 text-left">Action</th>
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
                                            <td class="py-2 px-4 space-x-2">
                                                <a href="/admin/product/${product.id}" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded">View</a>
                                                <a href="/admin/product/update/${product.id}" class="bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded">Update</a>
                                                <a href="/admin/product/delete/${product.id}" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">Delete</a>
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

        