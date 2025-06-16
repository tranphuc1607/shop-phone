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
    <title>Cập nhật sản phẩm</title>
    <style>
        * {
            cursor: pointer;
        }
        
        .form-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 2px;
            margin-bottom: 2rem;
        }
        
        .form-content {
            background: white;
            border-radius: 18px;
            padding: 2rem;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .input-field {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #ffffff;
        }
        
        .input-field:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .input-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #2d3748;
            font-size: 0.95rem;
        }
        
        .error-message {
            color: #e53e3e;
            font-size: 0.85rem;
            margin-top: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        
        .section-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }
        
        .image-preview-container {
            border: 3px dashed #cbd5e0;
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            background: linear-gradient(145deg, #f7fafc, #edf2f7);
        }
        
        .image-preview-container:hover {
            border-color: #667eea;
            background: linear-gradient(145deg, #edf2f7, #e2e8f0);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #718096 0%, #4a5568 100%);
            color: white;
            padding: 0.875rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 4px 15px rgba(113, 128, 150, 0.3);
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(113, 128, 150, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .page-title {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-align: center;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 2rem;
        }
        
        .alert-error {
            background: linear-gradient(135deg, #fc8181 0%, #e53e3e 100%);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(229, 62, 62, 0.3);
        }
        
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .file-input {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }
        
        .file-input input[type=file] {
            position: absolute;
            left: -9999px;
        }
        
        .file-input-label {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            cursor: pointer;
            display: block;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
        }
        
        .file-input-label:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(72, 187, 120, 0.4);
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
                display: none;
            }
            
            header {
                width: 100%;
                left: 0;
            }
            
            #content {
                margin-left: 0;
            }
            
            .grid-container {
                grid-template-columns: 1fr;
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
<body class="bg-gradient-to-br from-blue-50 via-purple-50 to-pink-50 min-h-screen">
    <div class="flex h-[100vh]">
        <jsp:include page="../layout/header.jsp" />
        <jsp:include page="../layout/navbar.jsp" />
        <div id="content" class="flex-1 pt-[60px] px-[20px] w-full ml-[260px]">
            <h1 class="page-title">Cập nhật sản phẩm</h1>

            <c:if test="${not empty errorMessage}">
                <div class="alert-error">
                    <strong>⚠️ Lỗi:</strong> ${errorMessage}
                </div>
            </c:if>

            <form:form method="POST" modelAttribute="updateProduct" action="/admin/product/update/${updateProduct.id}" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${updateProduct.id}" />
                
                <!-- Thông tin cơ bản -->
                <div class="form-section">
                    <div class="form-content">
                        <div class="section-header">
                            📱 Thông tin cơ bản sản phẩm
                        </div>
                        
                        <div class="grid-container">
                            <div class="input-group">
                                <label for="name" class="input-label">🏷️ Tên sản phẩm</label>
                                <form:input path="name" id="name" class="input-field" placeholder="Nhập tên sản phẩm..." />
                                <form:errors path="name" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="description" class="input-label">📝 Mô tả sản phẩm</label>
                                <form:input path="description" id="description" class="input-field" placeholder="Nhập mô tả..." />
                                <form:errors path="description" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="price" class="input-label">💰 Giá bán</label>
                                <form:input path="price" id="price" class="input-field" placeholder="Nhập giá..." />
                                <form:errors path="price" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="stockQuantity" class="input-label">📦 Số lượng kho</label>
                                <form:input path="stockQuantity" id="stockQuantity" class="input-field" placeholder="Nhập số lượng..." />
                                <form:errors path="stockQuantity" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="brand" class="input-label">🏢 Thương hiệu</label>
                                <form:select path="brand.id" id="brand" class="input-field">
                                    <c:forEach var="brandItem" items="${listBrand}">
                                        <option value="${brandItem.id}" 
                                            ${brandItem.id == updateProduct.brand.id ? 'selected="selected"' : ''}>
                                            ${brandItem.name}
                                        </option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="brand.id" class="error-message" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Thông số kỹ thuật -->
                <div class="form-section">
                    <div class="form-content">
                        <div class="section-header">
                            ⚙️ Thông số kỹ thuật
                        </div>
                        
                        <div class="grid-container">
                            <div class="input-group">
                                <label for="ram" class="input-label">🧠 RAM</label>
                                <form:input path="specification.ram" id="ram" class="input-field" placeholder="VD: 8GB, 16GB..." />
                                <form:errors path="specification.ram" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="storage" class="input-label">💾 Bộ nhớ trong</label>
                                <form:input path="specification.storage" id="storage" class="input-field" placeholder="VD: 256GB, 512GB..." />
                                <form:errors path="specification.storage" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="screen" class="input-label">📺 Màn hình</label>
                                <form:input path="specification.screen" id="screen" class="input-field" placeholder="VD: 6.1 inch, OLED..." />
                                <form:errors path="specification.screen" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="battery" class="input-label">🔋 Pin</label>
                                <form:input path="specification.battery" id="battery" class="input-field" placeholder="VD: 4000mAh..." />
                                <form:errors path="specification.battery" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="os" class="input-label">💻 Hệ điều hành</label>
                                <form:input path="specification.os" id="os" class="input-field" placeholder="VD: iOS 17, Android 14..." />
                                <form:errors path="specification.os" class="error-message" />
                            </div>
                            
                            <div class="input-group">
                                <label for="chipset" class="input-label">⚡ Chipset</label>
                                <form:input path="specification.chipset" id="chipset" class="input-field" placeholder="VD: Apple A17, Snapdragon 8..." />
                                <form:errors path="specification.chipset" class="error-message" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upload ảnh -->
                <div class="form-section">
                    <div class="form-content">
                        <div class="section-header">
                            🖼️ Hình ảnh sản phẩm
                        </div>
                        
                        <div class="input-group">
                            <label class="input-label">📸 Chọn ảnh sản phẩm</label>
                            <div class="file-input">
                                <input type="file" id="image-upload" name="productFile" accept="image/*" onchange="previewSingleImage(event)" />
                                <label for="image-upload" class="file-input-label">
                                    📁 Chọn file ảnh
                                </label>
                            </div>
                            <form:errors path="image" class="error-message" />
                        </div>

                        <div class="input-group">
                            <label class="input-label">👁️ Xem trước ảnh</label>
                            <div id="image-preview" class="image-preview-container">
                                <div class="text-gray-500 text-lg">
                                    🖼️ Chưa có ảnh nào được chọn
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Nút hành động -->
                <div class="flex flex-col sm:flex-row justify-center gap-4 mb-8">
                    <button type="submit" class="btn-primary">
                        ✅ Cập nhật sản phẩm
                    </button>
                    <a href="/admin/product" class="btn-secondary text-center">
                        ↩️ Trở lại
                    </a>
                </div>
            </form:form>
        </div>
    </div>

    <script>
        function previewSingleImage(event) {
            const preview = document.getElementById("image-preview");
            const file = event.target.files[0];
            
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.innerHTML = `
                        <img src="${e.target.result}" 
                             class="max-w-full max-h-64 object-contain rounded-lg shadow-lg mx-auto" 
                             alt="Preview" />
                        <p class="text-sm text-gray-600 mt-2">📁 ${file.name}</p>
                    `;
                };
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = `
                    <div class="text-gray-500 text-lg">
                        🖼️ Chưa có ảnh nào được chọn
                    </div>
                `;
            }
        }

        // Dropdown functionality
        const dropdownButton = document.getElementById('dropdown');
        const dropdownMenu = document.getElementById('dropdownMenu');

        if (dropdownButton && dropdownMenu) {
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
        }

        // Second dropdown
        const dropdownShowOrder = document.getElementById('dropdownShowOrder');
        const dropdownOrder = document.getElementById('dropdownOrder');

        if (dropdownShowOrder && dropdownOrder) {
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
        }

        // Navigation toggle
        const toggleBtn = document.getElementById('icon--list');
        const nav = document.querySelector('nav');
        const header = document.getElementById('header');
        const content = document.getElementById('content');

        if (toggleBtn && nav && header && content) {
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
        }
    </script>
</body>
</html>