<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <title>Sản phẩm của chúng tôi</title>
    </head>
    <body>
        <div>
            <div class ="bg-[#fff]">
                    <jsp:include page="../layout/layout.jsp" />
            </div>
            <div class="grid grid-cols-12 ">
                <div class="col-span-3  p-4 sm:block hidden border-r-2">
                    <div class="p-3">
                        <div class="mb-6">
                          <h3 class="font-semibold text-lg mb-2">Nhà sản xuất</h3>
                          <div class="flex flex-wrap gap-2">
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="IPHONE" id="factory-1">
                              <span>Iphone</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="SAMSUNG" id="factory-2">
                              <span>Samsung</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="XIAOME" id="factory-3">
                              <span>Xiaome</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="NOKIA" id="factory-4">
                              <span>Nokia</span>
                            </label>
                          </div>
                        </div>
                        <div class="mb-6">
                          <h3 class="font-semibold text-lg mb-2">Mục đích sử dụng</h3>
                          <div class="flex flex-wrap gap-2">
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="GAMING" id="target-1">
                              <span>Trò chơi</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="SINHVIEN-VANPHONG" id="target-2">
                              <span>Học sinh</span>
                            </label>
                          </div>
                        </div>
                      
                        <div class="mb-6">
                          <h3 class="font-semibold text-lg mb-2">Giá</h3>
                          <div class="flex flex-wrap gap-2">
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="duoi-10-trieu" id="price-1">
                              <span>Khoảng 10M</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="checkbox" class="form-checkbox text-blue-600" value="10-15-trieu" id="price-2">
                              <span>10 - 15M</span>
                            </label>
                          </div>
                        </div>
                      
                        <div class="mb-6">
                          <h3 class="font-semibold text-lg mb-2">Sort</h3>
                          <div class="flex flex-col gap-2">
                            <label class="inline-flex items-center space-x-2">
                              <input type="radio" name="radio-sort" value="gia-tang-dan" class="form-radio text-blue-600" id="sort-1">
                              <span>Tăng dần</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="radio" name="radio-sort" value="gia-giam-dan" class="form-radio text-blue-600" id="sort-2">
                              <span>Giảm dần</span>
                            </label>
                            <label class="inline-flex items-center space-x-2">
                              <input type="radio" name="radio-sort" value="gia-nothing" class="form-radio text-blue-600" id="sort-3" checked>
                              <span>Không sắp xếp</span>
                            </label>
                          </div>
                        </div>
                      
                        <!-- Filter Button -->
                        <div>
                          <button id="btnFilter" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                            Lọc sản phẩm
                          </button>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 sm:col-span-9 p-4">
                    <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
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
                </div>
              </div>
        </div>
    </body>
    </html>