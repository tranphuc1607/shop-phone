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
                <nav class = "w-[260px] h-full bg-[#fff] border-r-2 fixed">
                    <h1 class ="h-[60px] text-center leading-[60px] text-[30px] font-bold text-[#79CDCD] drop-shadow-xl">ShopPhone</h1>
                    <ul class="h-[240px]">
                        <li class ="">
                            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10  " href ="/admin/dashboard">
                                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zm320 96c0-26.9-16.5-49.9-40-59.3L280 88c0-13.3-10.7-24-24-24s-24 10.7-24 24l0 204.7c-23.5 9.5-40 32.5-40 59.3c0 35.3 28.7 64 64 64s64-28.7 64-64zM144 176a32 32 0 1 0 0-64 32 32 0 1 0 0 64zm-16 80a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zm288 32a32 32 0 1 0 0-64 32 32 0 1 0 0 64zM400 144a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"/></svg>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/user">
                                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z"/></svg>
                                <p >Users</p>
                            </a>
                        </li>
                        <li >
                            <a class ="flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/product">
                                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M160 265.2c0 8.5-3.4 16.6-9.4 22.6l-26.8 26.8c-12.3 12.3-32.5 11.4-49.4 7.2C69.8 320.6 65 320 60 320c-33.1 0-60 26.9-60 60s26.9 60 60 60c6.3 0 12 5.7 12 12c0 33.1 26.9 60 60 60s60-26.9 60-60c0-5-.6-9.8-1.8-14.5c-4.2-16.9-5.2-37.1 7.2-49.4l26.8-26.8c6-6 14.1-9.4 22.6-9.4l89.2 0c6.3 0 12.4-.3 18.5-1c11.9-1.2 16.4-15.5 10.8-26c-8.5-15.8-13.3-33.8-13.3-53c0-61.9 50.1-112 112-112c8 0 15.7 .8 23.2 2.4c11.7 2.5 24.1-5.9 22-17.6C494.5 62.5 422.5 0 336 0C238.8 0 160 78.8 160 176l0 89.2z"/></svg>
                                <p >Products</p>
                            </a>
                        </li>
                        <li>
                            <div id="dropdownShowOrder" class =" relative flex h-[60px] pl-[20px] items-center hover:border-[#1890FF] hover:border-r-2  hover:bg-[#1890FF]/10 " href ="/admin/order">
                                <svg class="h-[20px] w-[20px] mr-[10px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M48 0C21.5 0 0 21.5 0 48L0 368c0 26.5 21.5 48 48 48l16 0c0 53 43 96 96 96s96-43 96-96l128 0c0 53 43 96 96 96s96-43 96-96l32 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l0-64 0-32 0-18.7c0-17-6.7-33.3-18.7-45.3L512 114.7c-12-12-28.3-18.7-45.3-18.7L416 96l0-48c0-26.5-21.5-48-48-48L48 0zM416 160l50.7 0L544 237.3l0 18.7-128 0 0-96zM112 416a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm368-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>
                                <p >Orders</p> 
                                <div id="dropdownOrder" class=" h-[200px] font-[600] text-[16px] absolute bottom-[-200px] right-0 z-10 mt-2 w-[260px] bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none hidden">
                                    <div class="py-1">
                                      <ul>
                                        <li class="hover:bg-[#1890FF]/20">
                                          <a href ="#" class=" block px-4 py-2 text-sm text-gray-700">Tất cả đơn hàng</a>
                                        </li>
                                        <li class="hover:bg-[#1890FF]/20">
                                          <a href ="#" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng chưa xác nhận</a>
                                        </li>
                                        <li class="hover:bg-[#1890FF]/20">
                                          <a href ="#" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã xác nhận</a>
                                        </li>
                                        <li class="hover:bg-[#1890FF]/20">
                                          <a href ="#" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã xử lí</a>
                                        </li>
                                        <li class="hover:bg-[#1890FF]/20">
                                          <a href ="#" class=" block px-4 py-2 text-sm text-gray-700">Đơn hàng đã hoàn thành</a>
                                        </li>
                                      </ul>
                                    </div>
                                </div>
                            </div>           
                        </li>
                    </ul>
                </nav>
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
                                    <p class="font-bold text-[20px]">7374</p>
                                    <button class ="ml-[20px] flex border-2 w-[80px] h-full rounded-[5px] border-[#52c41a] bg-[#e8f4ff] text-[#52c41a]">
                                        <svg class ="fill-[#52c41a] mr-[4px]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M384 160c-17.7 0-32-14.3-32-32s14.3-32 32-32l160 0c17.7 0 32 14.3 32 32l0 160c0 17.7-14.3 32-32 32s-32-14.3-32-32l0-82.7L342.6 374.6c-12.5 12.5-32.8 12.5-45.3 0L192 269.3 54.6 406.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160c12.5-12.5 32.8-12.5 45.3 0L320 306.7 466.7 160 384 160z"/></svg>
                                        <p>774747</p>
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

// Hàm kiểm tra kích thước màn hình
function isLargeScreen() {
  return window.innerWidth >= 1024;
}

let isHidden = localStorage.getItem('navHidden') === 'true';

// Cập nhật layout tùy thuộc vào kích thước màn hình
function updateLayout() {
  if (isLargeScreen()) {
    // Màn hình lớn (lg trở lên)
    if (isHidden) {
      nav.classList.add('hidden');
      header.style.width = '100%';
      header.style.left = '0';
      content.style.marginLeft = '0';
    } else {
      nav.classList.remove('hidden');
      header.style.width = 'calc(100% - 260px)';
      header.style.left = '260px';
      content.style.marginLeft = '260px';
    }
  } else {
    // Màn hình nhỏ hơn lg (mobile, tablet)
    header.style.width = '100%';
    header.style.left = '0';
    content.style.marginLeft = '0';
      nav.classList.remove('show'); // Đảm bảo nav không hiện
  }
}

// Toggle khi bấm nút
toggleBtn.addEventListener('click', () => {
  isHidden = !isHidden;
  if (isLargeScreen()) {
    localStorage.setItem('navHidden', isHidden); // Lưu trạng thái nếu màn hình lớn
  }
  updateLayout();
});

// Gọi khi load và khi resize
updateLayout();
window.addEventListener('resize', updateLayout);



        </script>
        </body>
        </html>

        