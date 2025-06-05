<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>

<body class="bg-gray-50 font-sans">
    <jsp:include page="../layout/layout.jsp"/>

    <div class="container mx-auto px-4 py-10">
        <div class="flex flex-col md:flex-row gap-10">
            <!-- Left: Product Image -->
            <div class="md:w-1/2">
                <img src="/images/products/${product.image}" class="w-full rounded-lg shadow" alt="${product.name}">
            </div>

            <!-- Right: Product Details -->
            <div class="md:w-1/2">
                <h2 class="text-3xl font-bold mb-3">${product.name}</h2>
                <h3 class="text-xl text-red-600 font-semibold mb-4">
                    <fmt:formatNumber type="number" value="${product.price}" /> VND
                </h3>
                <!-- Brand -->
            <p class="mb-2 text-gray-700">
                <strong>Brand:</strong> ${product.brand.name}
            </p>

            <!-- Product Specification -->
            <div class="mb-4 text-gray-700">
                <strong>Specifications:</strong>
                <ul class="list-disc list-inside ml-4">
                    <li><strong>OS:</strong> ${product.specification.os}</li>
                    <li><strong>RAM:</strong> ${product.specification.ram} GB</li>
                    <li><strong>Storage:</strong> ${product.specification.storage} GB</li>
                    <li><strong>Screen:</strong> ${product.specification.screen} inch</li>
                    <li><strong>Battery:</strong> ${product.specification.battery} mAh</li>
                    <li><strong>Chipset:</strong> ${product.specification.chipset}</li>
                    
                </ul>
                <p id="stockQuantity" value=${product.stockQuantity}><strong>Số lượng hàng còn lại:</strong> ${product.stockQuantity}</p>
            </div>

                <!-- Quantity selector -->
                <div class="flex items-center space-x-2 mb-4">
                    <button type="button" onclick="updateQuantity(-1)" class="w-8 h-8 border rounded-full">-</button>
                    <c:if test="${not empty quantityBeforeUpdate}">
                        <input type="text" id="quantityDisplay" value=${quantityBeforeUpdate} class="w-12 text-center border rounded bg-gray-100" readonly>
                    </c:if>
                     <c:if test="${empty quantityBeforeUpdate}">
                        <input type="text" id="quantityDisplay" value="1" class="w-12 text-center border rounded bg-gray-100" readonly>
                    </c:if>
                    <button type="button" onclick="updateQuantity(1)" class="w-8 h-8 border rounded-full">+</button>
                </div>
                <c:if test="${empty quantityBeforeUpdate}">
                    <!-- Add to Cart Form -->
                    <form method="post" action="/cart/add/${product.id}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" name="productId" value="${product.id}" />
                        <input type="hidden" name="quantity" id="quantityInput" value="1" />

                        <button type="submit"
                            class="flex items-center gap-2 bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition">
                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                        </button>
                    </form>
                </c:if>

                <c:if test="${not empty quantityBeforeUpdate}">
                    <!-- Add to Cart Form -->
                    <form method="post" action="/cart/updateItemCart/${cartItemId}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" name="quantity" id="quantityInput" value=${quantityBeforeUpdate} />

                        <button type="submit"
                            class="flex items-center gap-2 bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition">
                            <i class="fa fa-shopping-cart"></i> Cập nhật giỏ hàng
                        </button>
                    </form>
                </c:if>
            </div>
        </div>

        <!-- Description Section -->
        <div class="mt-10">
            <h3 class="text-2xl font-semibold mb-4">Description</h3>
            <p class="text-gray-700">${product.description}</p>
        </div>
    </div>

    <!-- JS Quantity Logic -->
    <script>
        function updateQuantity(change) {
            const quantityInput = document.getElementById('quantityInput');
            const quantityDisplay = document.getElementById('quantityDisplay');
            const stockQuantity = parseInt(document.getElementById('stockQuantity').getAttribute('value'));

            let quantity = parseInt(quantityInput.value);
            quantity = isNaN(quantity) ? 1 : quantity + change;
            if (quantity < 1) quantity = 1;
            if (quantity > stockQuantity) {
                quantity = stockQuantity;
                alert('Số lượng vượt quá số lượng hàng còn lại!');
            }
            quantityInput.value = quantity;
            quantityDisplay.value = quantity;
        }
    </script>
</body>
</html>
