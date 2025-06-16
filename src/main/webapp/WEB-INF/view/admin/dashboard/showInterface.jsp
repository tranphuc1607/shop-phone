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
        <body>
            <div class ="flex h-[100vh]">
              <jsp:include page="../layout/header.jsp" />
              <jsp:include page="../layout/navbar.jsp" />
              <div id="content" style="z-index:-20;" class="flex-1 pt-[120px] px-[20px] w-full ml-[260px]">
                  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 flex gap-4">
                      <div class=" p-5 rounded-lg border-2 h-[137px]">
                          <p class ="mb-[7px]">Tổng lượt truy cập website </p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">${countVisit}</p>
                          </div>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Tổng người dùng</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">${totalCurrentUser}</p>
                          </div>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Tổng đơn hàng</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">${totalOrder}</p>
                          </div>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Tổng doanh thu </p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">${sum}</p>
                          </div>
                      </div>
                    </div>
                  <div class ="mt-[50px] flex justify-between">
                      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 w-full">
                          <div class="col-span-1">
                            <canvas id="chart1" width="400" height="200"></canvas>
                          </div>
                          <div class="col-span-1">
                            <canvas id="chart2" width="400" height="200"></canvas>
                          </div>
                          <div class="col-span-1 mt-[30px]">
                            <canvas id="chart3" width="400" height="200"></canvas>
                          </div>
                          <div class="col-span-1 mt-[30px]">
                            <canvas id="chart4" width="400" height="200"></canvas>
                          </div>
                        </div>
                        <div class="overflow-x-auto mt-[30px] hidden xl:block">
                          <table class="w-[300px] table-auto border-collapse border border-gray-300">
                            <thead>
                              <tr class="bg-gray-100 text-left">
                                <th class="px-4 py-2 border border-gray-300">Số thứ tự</th>
                                <th class="px-4 py-2 border border-gray-300">Tổng tiền</th>
                                <th class="px-4 py-2 border border-gray-300">Thời gian đặt hàng</th>
                              </tr>
                            </thead>
                            <tbody>

                               <c:forEach var="order" items="${orders}">
                                  <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">${order.getId()}</td>
                                <td class="px-4 py-2 border border-gray-300">${order.getTotalAmount()}</td>
                                <td class="px-4 py-2 border border-gray-300">${order.getOrderDate()}</td>
                              </tr>
                               </c:forEach>
                              
                              
                            </tbody>
                          </table>
                            <div class="mt-8">
                            <div class="flex justify-center items-center space-x-2">
                                <c:choose>
                                    <c:when test="${totalPages <= 7}">
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <a href="?page=${i}&size=${size}"
                                               class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                      ${i == currentPage ? 'bg-gradient-to-r from-orange-500 to-red-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="?page=1&size=${size}"
                                           class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                  ${currentPage == 1 ? 'bg-gradient-to-r from-orange-500 to-red-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">1</a>

                                        <c:if test="${currentPage > 4}">
                                            <span class="px-3 py-2 text-gray-500">...</span>
                                        </c:if>

                                        <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}">
                                            <c:if test="${i > 1 && i < totalPages}">
                                                <a href="?page=${i}&size=${size}"
                                                   class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                          ${i == currentPage ? 'bg-gradient-to-r from-orange-500 to-red-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                                    ${i}
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages - 3}">
                                            <span class="px-3 py-2 text-gray-500">...</span>
                                        </c:if>

                                        <a href="?page=${totalPages}&size=${size}"
                                           class="pagination-btn px-4 py-2 rounded-lg font-medium transition-all duration-300
                                                  ${currentPage == totalPages ? 'bg-gradient-to-r from-orange-500 to-red-600 text-white shadow-lg' : 'bg-white text-gray-700 hover:bg-gray-50 border border-gray-300'}">
                                            ${totalPages}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        </div>
                        
                  </div>
              </div>
            </div>
            <script>
                const ctx1 = document.getElementById('chart1').getContext('2d');

                const chart1 = new Chart(ctx1, {
                    type: 'line',
                    data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6','T7'],
                    datasets: [{
                        label: 'Total page view',
                        data:  [1000, 2000, 1500, 3000, 2500, 2000,500],
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: '#4bc0c0',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    }]
                    },
                    options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true }
                    }
                    }
                });

                const ctx2 = document.getElementById('chart2').getContext('2d');
                const chart2 = new Chart(ctx2, {
                    type: 'bar',
                    data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6','T7'],
                    datasets: [{
                        label: 'Total Users',
                        data:  [1000, 2000, 1500, 3000, 2500, 4000,500],
                        backgroundColor: '#36A2EB',
                        borderWidth: 1
                    }]
                    },
                    options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
                }
            });
            const ctx3 = document.getElementById('chart3').getContext('2d');
            const chart3 = new Chart(ctx3, {
                type: 'bar',
                data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6','T7'],
                datasets: [{
                    label: 'Total Oders',
                    data:  [1000, 2000, 1500, 3000, 2500, 4000,500],
                    backgroundColor: '#FF6384',
                    borderWidth: 1
                }]
                },
                options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
                }
            });
            const ctx4 = document.getElementById('chart4').getContext('2d');
            const chart4 = new Chart(ctx4, {
                type: 'line',
                data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6','T7'],
                datasets: [{
                    label: 'Total Sales',
                    data: [1000, 2000, 1500, 3000, 2500, 4000,500 ],
                    backgroundColor: 'rgba(255, 206, 86, 0.2)',
                    borderColor: '#FFCE56',
                    borderWidth: 2,
                    tension: 0.4,
                    fill: true
                }]
                },
                options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
                }
            });

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

        