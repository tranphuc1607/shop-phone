<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">

    <div class="container mx-auto p-8">
        <div class="bg-white p-6 rounded-lg shadow-md">
            <h1 class="text-3xl font-bold text-gray-800 mb-6">Product Details</h1>

            <!-- Product Info Section -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Product Image -->
                <div class="flex justify-center">
                    <img src="<c:url value='/images/${product.id}.jpg' />" alt="Product Image" class="max-w-full h-auto rounded-lg shadow-md">
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
                    <li><strong>Processor:</strong> <c:out value="${product.specification.processor}" /></li>
                    <li><strong>RAM:</strong> <c:out value="${product.specification.ram}" /></li>
                    <li><strong>Storage:</strong> <c:out value="${product.specification.storage}" /></li>
                    <li><strong>Graphics:</strong> <c:out value="${product.specification.graphics}" /></li>
                </ul>
            </div>

            <!-- Related Cart Items -->
            <div class="mt-8">
                <h2 class="text-2xl font-semibold text-gray-800 mb-3">Related Cart Items</h2>
                <ul class="list-disc pl-6">
                    <c:forEach var="item" items="${cartItems}">
                        <li>${item.product.name} x ${item.quantity}</li>
                    </c:forEach>
                </ul>
            </div>

            <!-- Related Order Items -->
            <div class="mt-8">
                <h2 class="text-2xl font-semibold text-gray-800 mb-3">Order Items</h2>
                <ul class="list-disc pl-6">
                    <c:forEach var="orderItem" items="${orderItems}">
                        <li>${orderItem.product.name} x ${orderItem.quantity}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

</body>

</html>
