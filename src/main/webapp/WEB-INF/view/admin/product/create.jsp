<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create product</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<div class="w-1/2 mx-auto mt-10 p-6 bg-white shadow-md rounded-lg">
    <h2 class="text-2xl font-semibold text-center mb-6">Create New Product</h2>

    <!-- Hiển thị lỗi toàn cục nếu có -->
    <c:if test="${not empty errorMessage}">
        <div class="bg-red-500 text-white p-4 rounded mb-6">
            <strong>Error:</strong> ${errorMessage}
        </div>
    </c:if>

    <form:form method="POST" modelAttribute="newProduct" action="/admin/product/create" enctype="multipart/form-data">
        <div class="grid grid-cols-2 gap-4 mb-6">
            <div>
                <label for="name" class="block font-semibold">Product Name</label>
                <form:input path="name" id="name" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="name" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="description" class="block font-semibold">Description</label>
                <form:input path="description" id="description" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="description" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="price" class="block font-semibold">Price</label>
                <form:input path="price" id="price" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="price" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="stockQuantity" class="block font-semibold">Stock Quantity</label>
                <form:input path="stockQuantity" id="stockQuantity" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="stockQuantity" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="brand" class="block font-semibold">Brand</label>
                <form:select path="brand.id" id="brand" class="w-full p-2 border rounded ">
                    <c:forEach var="brandItem" items="${listBrand}">
                        <option  value="${brandItem.id}">${brandItem.name}</option>
                    </c:forEach>
                </form:select>
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="brand.id" class="text-red-500 text-sm" />
            </div>
        </div>

        <!-- Thông số kỹ thuật -->
        <div class="grid grid-cols-1 bg-blue-200">
            <div class="w-full p-2 border rounded text-center font-bold">Specifications</div>
        </div>

        <div class="grid grid-cols-2 gap-4 mb-6">
            <div>
                <label for="ram" class="block font-semibold">RAM</label>
                <form:input path="specification.ram" id="ram" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.ram" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="storage" class="block font-semibold">Storage</label>
                <form:input path="specification.storage" id="storage" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.storage" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="screen" class="block font-semibold">Screen</label>
                <form:input path="specification.screen" id="screen" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.screen" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="battery" class="block font-semibold">Battery</label>
                <form:input path="specification.battery" id="battery" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.battery" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="os" class="block font-semibold">Operating System</label>
                <form:input path="specification.os" id="os" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.os" class="text-red-500 text-sm" />
            </div>
            <div>
                <label for="chipset" class="block font-semibold">Chipset</label>
                <form:input path="specification.chipset" id="chipset" class="w-full p-2 border rounded" />
                <!-- Hiển thị lỗi cho trường này -->
                <form:errors path="specification.chipset" class="text-red-500 text-sm" />
            </div>
        </div>

        <!-- Upload 1 ảnh -->
        <div class="mb-6">
            <label for="image-upload" class="font-bold block mb-2">Chọn ảnh sản phẩm</label>
            <input type="file" id="image-upload" name="productFile" accept="image/*" onchange="previewSingleImage(event)" class="w-full" />
            <!-- Hiển thị lỗi cho trường này -->
            <form:errors path="image" class="text-red-500 text-sm" />
        </div>

        <!-- Xem trước ảnh -->
        <div class="mb-6">
            <label class="block text-lg font-semibold mb-2">Xem trước ảnh:</label>
            <div id="image-preview" class="w-full h-64 border rounded-lg overflow-hidden flex items-center justify-center">
                <span class="text-gray-500">Chưa có ảnh nào được chọn</span>
            </div>
        </div>

        <div class="flex justify-center">
            <button type="submit" class="w-1/2 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700">
                Create Product
            </button>
        </div>
    </form:form>
</div>

<script>
    function previewSingleImage(event) {
        const preview = document.getElementById("image-preview");
        preview.innerHTML = "";

        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement("img");
                img.src = e.target.result;
                img.classList.add("object-contain", "h-full", "w-full");
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = '<span class="text-gray-500">Chưa có ảnh nào được chọn</span>';
        }
    }
</script>

</body>
</html>
