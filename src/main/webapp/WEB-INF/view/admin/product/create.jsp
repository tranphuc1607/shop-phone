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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        .form-section {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .form-section:hover {
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .input-group {
            position: relative;
        }

        .input-group input, .input-group select {
            transition: all 0.3s ease;
        }

        .input-group input:focus, .input-group select:focus {
            transform: translateY(-1px);
            box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.15);
        }

        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .tech-specs-bg {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .preview-area {
            background: linear-gradient(145deg, #f8fafc 0%, #e2e8f0 100%);
            border: 2px dashed #cbd5e1;
            transition: all 0.3s ease;
        }

        .preview-area:hover {
            border-color: #3b82f6;
            background: linear-gradient(145deg, #eff6ff 0%, #dbeafe 100%);
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6b7280 0%, #374151 100%);
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(107, 114, 128, 0.4);
        }

        .icon-wrapper {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }

    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 to-blue-50 min-h-screen">

    <div class="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        <div id="content" style="z-index: -10;" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
            
            <!-- Header Section -->
            <div class="mb-8">
                <div class="flex items-center justify-center mb-4">
                    <div class="icon-wrapper">
                        <i class="fas fa-plus text-white text-lg"></i>
                    </div>
                    <h2 class="text-3xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
                        Tạo mới sản phẩm
                    </h2>
                </div>
                <p class="text-center text-gray-600">Thêm sản phẩm mới vào hệ thống</p>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border-l-4 border-red-400 p-4 rounded-lg mb-6 shadow-sm">
                    <div class="flex items-center">
                        <i class="fas fa-exclamation-triangle text-red-400 mr-3"></i>
                        <div>
                            <strong class="text-red-800">Lỗi:</strong>
                            <span class="text-red-700 ml-2">${errorMessage}</span>
                        </div>
                    </div>
                </div>
            </c:if>

            <form:form method="POST" modelAttribute="newProduct" action="/admin/product/create" enctype="multipart/form-data" class="space-y-8">
                
                <!-- Basic Information Section -->
                <div class="form-section rounded-2xl p-6 shadow-lg">
                    <div class="gradient-bg text-white p-4 rounded-lg mb-6">
                        <h3 class="text-xl font-bold flex items-center">
                            <i class="fas fa-info-circle mr-3"></i>
                            Thông tin cơ bản
                        </h3>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="input-group">
                            <label for="name" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-tag text-blue-500 mr-2"></i>
                                Tên sản phẩm
                            </label>
                            <form:input path="name" id="name" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="Nhập tên sản phẩm..." />
                            <form:errors path="name" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="description" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-align-left text-green-500 mr-2"></i>
                                Mô tả
                            </label>
                            <form:input path="description" id="description" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="Nhập mô tả sản phẩm..." />
                            <form:errors path="description" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="price" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-dollar-sign text-yellow-500 mr-2"></i>
                                Giá
                            </label>
                            <form:input path="price" id="price" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="Nhập giá sản phẩm..." />
                            <form:errors path="price" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="stockQuantity" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-boxes text-purple-500 mr-2"></i>
                                Số lượng kho
                            </label>
                            <form:input path="stockQuantity" id="stockQuantity" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="Nhập số lượng..." />
                            <form:errors path="stockQuantity" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group md:col-span-2">
                            <label for="brand" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-copyright text-red-500 mr-2"></i>
                                Hãng
                            </label>
                            <form:select path="brand.id" id="brand" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none">
                                <c:forEach var="brandItem" items="${listBrand}">
                                    <option value="${brandItem.id}">${brandItem.name}</option>
                                </c:forEach>
                            </form:select>
                            <form:errors path="brand.id" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                    </div>
                </div>

                <!-- Technical Specifications Section -->
                <div class="form-section rounded-2xl p-6 shadow-lg">
                    <div class="tech-specs-bg text-white p-4 rounded-lg mb-6">
                        <h3 class="text-xl font-bold flex items-center">
                            <i class="fas fa-microchip mr-3"></i>
                            Đặc điểm sản phẩm
                        </h3>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="input-group">
                            <label for="ram" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-memory text-blue-500 mr-2"></i>
                                RAM
                            </label>
                            <form:input path="specification.ram" id="ram" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="VD: 8GB" />
                            <form:errors path="specification.ram" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="storage" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-hdd text-green-500 mr-2"></i>
                                Bộ nhớ
                            </label>
                            <form:input path="specification.storage" id="storage" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="VD: 256GB" />
                            <form:errors path="specification.storage" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="screen" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-tv text-purple-500 mr-2"></i>
                                Màn hình
                            </label>
                            <form:input path="specification.screen" id="screen" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="VD: 6.1 inch" />
                            <form:errors path="specification.screen" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="battery" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-battery-full text-orange-500 mr-2"></i>
                                Pin
                            </label>
                            <form:input path="specification.battery" id="battery" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none" placeholder="VD: 4000mAh" />
                            <form:errors path="specification.battery" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                        
                        <div class="input-group">
                            <label for="os" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-cog text-indigo-500 mr-2"></i>
                                Hệ điều hành
                            </label>
                            <form:select path="specification.os" id="os" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none">
                                <form:option value="" label="-- Chọn hệ điều hành --"/>
                                <form:option value="ANDROID">ANDROID</form:option>
                                <form:option value="IOS">IOS</form:option>
                                <form:option value="WINDOWS">WINDOWS</form:option>
                                <form:option value="LINUX">LINUX</form:option>
                            </form:select>
                            <form:errors path="specification.os" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>

                        <div class="input-group">
                            <label for="chipset" class="block font-bold text-gray-700 mb-2 flex items-center">
                                <i class="fas fa-microchip text-red-500 mr-2"></i>
                                Chipset
                            </label>
                            <form:select path="specification.chipset" id="chipset" class="w-full p-4 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:outline-none">
                                <form:option value="" label="-- Chọn chipset --"/>
                                <form:option value="Qualcomm">Qualcomm</form:option>
                                <form:option value="Exynos">Exynos</form:option>
                                <form:option value="Apple A">Apple A</form:option>
                                <form:option value="MediaTek">MediaTek</form:option>
                            </form:select>
                            <form:errors path="specification.chipset" class="text-red-500 text-sm mt-1 flex items-center">
                                <i class="fas fa-exclamation-circle mr-1"></i>
                            </form:errors>
                        </div>
                    </div>
                </div>

                <!-- Image Upload Section -->
                <div class="form-section rounded-2xl p-6 shadow-lg">
                    <div class="bg-gradient-to-r from-green-500 to-teal-500 text-white p-4 rounded-lg mb-6">
                        <h3 class="text-xl font-bold flex items-center">
                            <i class="fas fa-image mr-3"></i>
                            Hình ảnh sản phẩm
                        </h3>
                    </div>
                    
                    <div class="mb-6">
                        <label for="image-upload" class="block font-bold text-gray-700 mb-4 flex items-center">
                            <i class="fas fa-cloud-upload-alt text-blue-500 mr-2"></i>
                            Chọn ảnh sản phẩm
                        </label>
                        <div class="relative">
                            <input type="file" id="image-upload" name="productFile" accept="image/*" onchange="previewSingleImage(event)" 
                                   class="w-full p-4 border-2 border-dashed border-gray-300 rounded-xl focus:border-blue-500 focus:outline-none file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100" />
                        </div>
                        <form:errors path="image" class="text-red-500 text-sm mt-2 flex items-center">
                            <i class="fas fa-exclamation-circle mr-1"></i>
                        </form:errors>
                    </div>

                    <!-- Image Preview -->
                    <div class="mb-6">
                        <label class="block text-lg font-bold text-gray-700 mb-4 flex items-center">
                            <i class="fas fa-eye text-purple-500 mr-2"></i>
                            Xem trước ảnh:
                        </label>
                        <div id="image-preview" class="preview-area w-full h-64 rounded-xl overflow-hidden flex items-center justify-center">
                            <div class="text-center">
                                <i class="fas fa-image text-gray-400 text-4xl mb-2"></i>
                                <span class="text-gray-500 block">Chưa có ảnh nào được chọn</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-center space-x-6 pb-8">
                    <button type="submit" class="btn-primary flex items-center px-8 py-4 text-white font-bold rounded-xl shadow-lg">
                        <i class="fas fa-plus-circle mr-3"></i>
                        Tạo sản phẩm
                    </button> 
                    <a class="btn-secondary flex items-center px-8 py-4 text-white font-bold rounded-xl shadow-lg" href="/admin/product">
                        <i class="fas fa-arrow-left mr-3"></i>
                        Trở lại
                    </a>
                </div>
            </form:form>
            
        </div>
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
                img.classList.add("object-contain", "h-full", "w-full", "rounded-lg");
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = `
                <div class="text-center">
                    <i class="fas fa-image text-gray-400 text-4xl mb-2"></i>
                    <span class="text-gray-500 block">Chưa có ảnh nào được chọn</span>
                </div>
            `;
        }
    }
</script>
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