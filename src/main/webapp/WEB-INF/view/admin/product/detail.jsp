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

<body class="bg-gray-100">
    <div class ="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
            <div class="bg-white p-6 rounded-lg shadow-md">
            <h1 class="text-3xl font-bold text-gray-800 mb-6">Product Details</h1>

            <!-- Product Info Section -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Product Image -->
                <div class="flex justify-center">
                    <img src="/images/${product.image}" alt="Product Image" class="max-w-full h-auto rounded-lg shadow-md">
                </div>

                <!-- Product Information -->
                <div>
                    <div class="mb-4">
                        <label for="productName" class="block text-lg font-medium text-gray-700">Product Name</label>
                        <input type="text" id="productName" value="${product.name}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productDescription" class="block text-lg font-medium text-gray-700">Description</label>
                        <textarea id="productDescription" class="w-full p-3 border border-gray-300 rounded-lg mt-1" rows="4" disabled>${product.description}</textarea>
                    </div>
                    <div class="mb-4">
                        <label for="productPrice" class="block text-lg font-medium text-gray-700">Price</label>
                        <input type="text" id="productPrice" value="${product.price}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productStock" class="block text-lg font-medium text-gray-700">Stock Quantity</label>
                        <input type="number" id="productStock" value="${product.stockQuantity}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                    <div class="mb-4">
                        <label for="productBrand" class="block text-lg font-medium text-gray-700">Brand</label>
                        <input type="text" id="productBrand" value="${product.brand.name}" class="w-full p-3 border border-gray-300 rounded-lg mt-1" disabled>
                    </div>
                </div>
            </div>

            <!-- Product Specifications -->
            <div class="mt-8">
                <h2 class="text-2xl font-semibold text-gray-800 mb-3">Product Specifications</h2>
                <ul class="list-disc pl-6 space-y-2">
                    <li><strong>Screen:</strong> <c:out value="${product.specification.screen}" /></li>
                    <li><strong>RAM:</strong> <c:out value="${product.specification.ram}" /></li>
                    <li><strong>Storage:</strong> <c:out value="${product.specification.storage}" /></li>
                    <li><strong>Battery:</strong> <c:out value="${product.specification.battery}" /></li>
                    <li><strong>Os:</strong> <c:out value="${product.specification.os}" /></li>
                    <li><strong>Chipset:</strong> <c:out value="${product.specification.chipset}" /></li>
                </ul>
            </div>

        </div>
        <a style="width:400px;" href="/admin/product" class="mt-6 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">Back</a>

        </div>
    </div>

</body>

</html>
