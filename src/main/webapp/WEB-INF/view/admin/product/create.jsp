<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create product</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    <div class="w-1/2 mx-auto mt-10 p-6 bg-white shadow-md rounded-lg">
        <h2 class="text-2xl font-semibold text-center mb-6">Create New Product</h2>
    
        <form:form method="POST" modelAttribute="newProduct" action="/admin/product/create" enctype="multipart/form-data">
            <div class="grid grid-cols-2 gap-4 mb-6">
                <div>
                    <label for="name" class="block font-semibold">Product Name</label>
                    <form:input path="name" id="name" class="w-full p-2 border rounded" />
                </div>
                <div>
                    <label for="description" class="block font-semibold">Description</label>
                    <form:input path="description" id="description" class="w-full p-2 border rounded" />
                </div>
                <div>
                    <label for="price" class="block font-semibold">Price</label>
                    <form:input path="price" id="price" class="w-full p-2 border rounded" />
                </div>
                <div>
                    <label for="stockQuantity" class="block font-semibold">Stock Quantity</label>
                    <form:input path="stockQuantity" id="stockQuantity" class="w-full p-2 border rounded" />
                </div>
                <div>
                    <label for="brand" class="block font-semibold">Brand</label>
                    <form:select path="brand.id" id="brand" class="w-full p-2 border rounded">
                        <c:forEach var="brandItem" items="${listBrand}">
                            <option value="${brandItem.id}">${brandItem.name}</option>
                        </c:forEach>
                    </form:select>
                </div>
            </div>
            <div class="grid grid-cols-1 bg-blue-200">
                <div class="w-full p-2 border rounded text-center font-bold ">
                    Specifications
                </div>
            </div>
            <div class="grid grid-cols-2 gap-4 mb-6">
                <div>
                    <label for="ram" class="block font-semibold">RAM</label>
                    <form:input path="specification.ram" id="ram" class="w-full p-2 border rounded" />
                </div>
    
                <div>
                    <label for="storage" class="block font-semibold">Storage</label>
                    <form:input path="specification.storage" id="storage" class="w-full p-2 border rounded" />
                </div>
    
                <div>
                    <label for="screen" class="block font-semibold">Screen</label>
                    <form:input path="specification.screen" id="screen" class="w-full p-2 border rounded" />
                </div>
    
                <div>
                    <label for="battery" class="block font-semibold">Battery</label>
                    <form:input path="specification.battery" id="battery" class="w-full p-2 border rounded" />
                </div>
    
                <div>
                    <label for="os" class="block font-semibold">Operating System</label>
                    <form:input path="specification.os" id="os" class="w-full p-2 border rounded" />
                </div>
    
                <div>
                    <label for="chipset" class="block font-semibold">Chipset</label>
                    <form:input path="specification.chipset" id="chipset" class="w-full p-2 border rounded" />
                </div>
            </div>
    
        <div class="grid grid-cols-2 gap-4 flex flex-cols">
            <div>
                <label for="file-upload" class="font-bold">Chọn ảnh</label>
                <input type="file" id="file-upload" name="images"  onchange="handleFileSelect(event)" multiple="multiple"/>
            </div>
        </div>
            <div class="mt-4">
                <label class="block text-lg font-semibold">Review ảnh đã chọn:</label>
                <div id="image-preview" class="grid grid-cols-4 gap-4 mt-2">
                </div>
            </div>
            <input type="hidden" id="primaryImageIndex" name="primaryImageIndex" value="" />
            <div class="flex justify-center">
                <button type="submit" class="w-1/2 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700">
                    Create Product
                </button>
            </div>
        </form:form>
    </div>
    
    <script>
        let selectedFiles = [];
    
        function handleFileSelect(event) {
            const files = event.target.files;
            for (let i = 0; i < files.length; i++) {
                selectedFiles.push(files[i]);
            }
            updateImagePreview();
        }
    
        function updateImagePreview() {
            const previewContainer = document.getElementById('image-preview');
            previewContainer.innerHTML = '';
    
            selectedFiles.forEach((file, index) => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imgPreview = document.createElement('div');
                    imgPreview.classList.add('relative', 'border', 'rounded-lg', 'p-1');
                    imgPreview.dataset.index = index;
    
                    const imgElement = document.createElement('img');
                    imgElement.src = e.target.result;
                    imgElement.classList.add('w-full', 'h-32', 'object-cover', 'rounded-lg');
    
                    const removeButton = document.createElement('button');
                    removeButton.classList.add('absolute', 'top-0', 'right-0', 'text-white', 'bg-red-500', 'rounded-full', 'p-1', 'm-1');
                    removeButton.textContent = 'X';
                    removeButton.onclick = function () {
                        removeImage(index);
                    };
    
                    const primaryButton = document.createElement('button');
                    primaryButton.classList.add('mt-1', 'text-xs', 'bg-green-500', 'text-white', 'rounded', 'px-2', 'py-1', 'w-full');
                    primaryButton.textContent = 'Chọn làm ảnh chính';
                    primaryButton.onclick = function () {
                        event.preventDefault();
                        document.getElementById('primaryImageIndex').value = index;
                        highlightPrimaryImage();
                    };
    
                    imgPreview.appendChild(imgElement);
                    imgPreview.appendChild(removeButton);
                    imgPreview.appendChild(primaryButton);
                    previewContainer.appendChild(imgPreview);
                };
                reader.readAsDataURL(file);
            });
    
            highlightPrimaryImage();
        }
    
        function removeImage(index) {
            selectedFiles.splice(index, 1);
            updateImagePreview();
        }
    
        function highlightPrimaryImage() {
            const selectedIndex = document.getElementById('primaryImageIndex').value;
            const previews = document.querySelectorAll('#image-preview > div');
            previews.forEach((preview, index) => {
                if (index == selectedIndex) {
                    preview.classList.add('ring', 'ring-green-500', 'ring-2');
                } else {
                    preview.classList.remove('ring', 'ring-green-500', 'ring-2');
                }
            });
        }
    </script>
    
    
</body>
</html>


