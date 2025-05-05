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
              <div id="content" class="pt-[120px] px-[20px] w-full ml-[260px]">
                  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 flex gap-4">
                      <div class=" p-5 rounded-lg border-2 h-[137px]">
                          <p class ="mb-[7px]">Total page view</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">7374</p>
                              <button class ="ml-[20px] flex border-2 w-[80px] h-full rounded-[5px] border-[#1890ff] text-[#1890ff]">
                                  <svg class ="fill-[#1890ff] mr-[4px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M384 160c-17.7 0-32-14.3-32-32s14.3-32 32-32l160 0c17.7 0 32 14.3 32 32l0 160c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-82.7L342.6 374.6c-12.5 12.5-32.8 12.5-45.3 0L192 269.3 54.6 406.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160c12.5-12.5 32.8-12.5 45.3 0L320 306.7 466.7 160 384 160z"/></svg>
                                  <p>774747</p>
                              </button>
                          </div>
                          <p class="text-[12px]">You made an extra 2000 this week </p>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Total Users</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">${totalCurrentUser}</p>
                              <button class ="ml-[20px] flex border-2 w-[80px] h-full rounded-[5px] border-[#52c41a] bg-[#e8f4ff] text-[#52c41a]">
                                  <svg class ="fill-[#52c41a] mr-[4px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M384 160c-17.7 0-32-14.3-32-32s14.3-32 32-32l160 0c17.7 0 32 14.3 32 32l0 160c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-82.7L342.6 374.6c-12.5 12.5-32.8 12.5-45.3 0L192 269.3 54.6 406.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160c12.5-12.5 32.8-12.5 45.3 0L320 306.7 466.7 160 384 160z"/></svg>
                                  <p>${getTotalUsersLastSunday}%</p>
                              </button>
                          </div>
                          <p class="text-[12px]">You made an extra 2000 this week </p>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Total Orders</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">7374</p>
                              <button class ="ml-[20px] flex border-2 w-[80px] h-full rounded-[5px] border-[#faad14] bg-[#eef9e8] text-[#faad14]">
                                  <svg class ="fill-[#faad14] mr-[4px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M384 160c-17.7 0-32-14.3-32-32s14.3-32 32-32l160 0c17.7 0 32 14.3 32 32l0 160c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-82.7L342.6 374.6c-12.5 12.5-32.8 12.5-45.3 0L192 269.3 54.6 406.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160c12.5-12.5 32.8-12.5 45.3 0L320 306.7 466.7 160 384 160z"/></svg>
                                  <p>774747</p>
                              </button>
                          </div>
                          <p class="text-[12px]">You made an extra 2000 this week </p>
                      </div>
                      <div class="p-5 rounded-lg border-2 h-[137px] ">
                          <p class ="mb-[7px]">Total Sales</p>
                          <div class ="h-[26px] flex mb-[20px]">
                              <p class="font-bold text-[20px]">7374</p>
                              <button class ="ml-[20px] flex border-2 w-[80px] h-full rounded-[5px] border-[#ff4d4f] bg-[#ffeded] text-[#ff4d4f]">
                                  <svg class ="fill-[#ff4d4f] mr-[4px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M384 160c-17.7 0-32-14.3-32-32s14.3-32 32-32l160 0c17.7 0 32 14.3 32 32l0 160c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-82.7L342.6 374.6c-12.5 12.5-32.8 12.5-45.3 0L192 269.3 54.6 406.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160c12.5-12.5 32.8-12.5 45.3 0L320 306.7 466.7 160 384 160z"/></svg>
                                  <p>774747</p>
                              </button>
                          </div>
                          <p class="text-[12px]">You made an extra 2000 this week </p>
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
                                <th class="px-4 py-2 border border-gray-300">Mã đơn hàng</th>
                                <th class="px-4 py-2 border border-gray-300">Tổng tiền</th>
                                <th class="px-4 py-2 border border-gray-300">Thời gian đặt hàng</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">1</td>
                                <td class="px-4 py-2 border border-gray-300">ORD12345</td>
                                <td class="px-4 py-2 border border-gray-300">$120.00</td>
                                <td class="px-4 py-2 border border-gray-300">2025-04-27 10:30</td>
                              </tr>
                              <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">2</td>
                                <td class="px-4 py-2 border border-gray-300">ORD12346</td>
                                <td class="px-4 py-2 border border-gray-300">$150.50</td>
                                <td class="px-4 py-2 border border-gray-300">2025-04-26 14:45</td>
                              </tr>
                              <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">3</td>
                                <td class="px-4 py-2 border border-gray-300">ORD12347</td>
                                <td class="px-4 py-2 border border-gray-300">$99.99</td>
                                <td class="px-4 py-2 border border-gray-300">2025-04-25 09:15</td>
                              </tr>
                              <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">4</td>
                                <td class="px-4 py-2 border border-gray-300">ORD12348</td>
                                <td class="px-4 py-2 border border-gray-300">$80.00</td>
                                <td class="px-4 py-2 border border-gray-300">2025-04-24 11:30</td>
                              </tr>
                              <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">5</td>
                                <td class="px-4 py-2 border border-gray-300">ORD12349</td>
                                <td class="px-4 py-2 border border-gray-300">$200.75</td>
                                <td class="px-4 py-2 border border-gray-300">2025-04-23 16:00</td>
                              </tr>
                            </tbody>
                          </table>
                            <div class="mt-[30px]">
                              <button class="px-4 py-2 text-sm text-gray-700 bg-white border border-gray-300 rounded-l hover:bg-gray-100">Trước</button>
                              <button class="px-4 py-2 text-sm text-gray-700 bg-white border-t border-b border-gray-300 hover:bg-gray-100">1</button>
                              <button class="px-4 py-2 text-sm text-gray-700 bg-white border-t border-b border-gray-300 hover:bg-gray-100">2</button>
                              <button class="px-4 py-2 text-sm text-gray-700 bg-white border-t border-b border-gray-300 hover:bg-gray-100">3</button>
                              <button class="px-4 py-2 text-sm text-gray-700 bg-white border-t border-b border-gray-300 hover:bg-gray-100">Tiếp</button>
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
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                    datasets: [{
                        label: 'Total page view',
                        data: [120, 190, 300, 500, 200, 300],
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
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                    datasets: [{
                        label: 'Total Users',
                        data: [50, 60, 80, 100, 90, 120],
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
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                datasets: [{
                    label: 'Total Oders',
                    data: [20, 40, 60, 80, 100, 120],
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
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                datasets: [{
                    label: 'Total Sales',
                    data: [1000, 2000, 1500, 3000, 2500, 4000],
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

        