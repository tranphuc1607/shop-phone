<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng ${id}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-gray-100">
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/navbar.jsp" />
    <div class="flex min-h-screen pt-16">
        <!-- Sidebar/Navbar -->
        
        
        <!-- Main Content Area -->
        <div class="flex-1 ml-64">
            <main class="p-6">
                <!-- Page Header -->
                <div class="mb-8">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-900">Chi tiết người dùng</h1>
                            <p class="mt-1 text-sm text-gray-600">Thông tin chi tiết của người dùng ID: ${id}</p>
                        </div>
                        <div class="flex items-center space-x-3">
                            <a href="/admin/user/${id}/edit" 
                               class="inline-flex items-center px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-edit mr-2"></i>
                                Chỉnh sửa
                            </a>
                            <a href="/admin/user" 
                               class="inline-flex items-center px-4 py-2 bg-gray-500 hover:bg-gray-600 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>

                <!-- User Information Card -->
                <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                    <!-- Card Header -->
                    <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
                        <div class="flex items-center">
                            <div class="bg-white bg-opacity-20 rounded-full p-3 mr-4">
                                <i class="fas fa-user text-white text-xl"></i>
                            </div>
                            <div>
                                <h2 class="text-xl font-semibold text-white">Thông tin người dùng</h2>
                                <p class="text-blue-100 text-sm">Dữ liệu cá nhân và thông tin liên hệ</p>
                            </div>
                        </div>
                    </div>

                    <!-- Card Body -->
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Basic Information -->
                            <div class="space-y-4">
                                <h3 class="text-lg font-semibold text-gray-800 border-b border-gray-200 pb-2">
                                    <i class="fas fa-info-circle text-blue-600 mr-2"></i>
                                    Thông tin cơ bản
                                </h3>
                                
                                <div class="space-y-3">
                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                                            <i class="fas fa-hashtag text-blue-600 text-sm"></i>
                                        </div>
                                        <div>
                                            <label class="text-sm font-medium text-gray-600">ID</label>
                                            <p class="text-gray-900 font-semibold">${id}</p>
                                        </div>
                                    </div>

                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center mr-3">
                                            <i class="fas fa-user text-green-600 text-sm"></i>
                                        </div>
                                        <div>
                                            <label class="text-sm font-medium text-gray-600">Tên đầy đủ</label>
                                            <p class="text-gray-900 font-semibold">${user.name}</p>
                                        </div>
                                    </div>

                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-purple-100 rounded-full flex items-center justify-center mr-3">
                                            <i class="fas fa-user-tag text-purple-600 text-sm"></i>
                                        </div>
                                        <div>
                                            <label class="text-sm font-medium text-gray-600">Vai trò</label>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                                ${user.role == 'ADMIN' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">
                                                <c:choose>
                                                    <c:when test="${user.role == 'ADMIN'}">
                                                        <i class="fas fa-crown mr-1"></i>Quản trị viên
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-user mr-1"></i>Người dùng
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="space-y-4">
                                <h3 class="text-lg font-semibold text-gray-800 border-b border-gray-200 pb-2">
                                    <i class="fas fa-address-book text-green-600 mr-2"></i>
                                    Thông tin liên hệ
                                </h3>
                                
                                <div class="space-y-3">
                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                                            <i class="fas fa-envelope text-blue-600 text-sm"></i>
                                        </div>
                                        <div class="flex-1">
                                            <label class="text-sm font-medium text-gray-600">Email</label>
                                            <p class="text-gray-900 font-semibold break-all">${user.email}</p>
                                        </div>
                                        <a href="mailto:${user.email}" 
                                           class="text-blue-600 hover:text-blue-800 transition">
                                            <i class="fas fa-external-link-alt"></i>
                                        </a>
                                    </div>

                                    <div class="flex items-center p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-green-100 rounded-full flex items-center justify-center mr-3">
                                            <i class="fas fa-phone text-green-600 text-sm"></i>
                                        </div>
                                        <div class="flex-1">
                                            <label class="text-sm font-medium text-gray-600">Số điện thoại</label>
                                            <p class="text-gray-900 font-semibold">
                                                <c:choose>
                                                    <c:when test="${not empty user.phone}">
                                                        ${user.phone}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-400 italic">Chưa cập nhật</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <c:if test="${not empty user.phone}">
                                            <a href="tel:${user.phone}" 
                                               class="text-green-600 hover:text-green-800 transition">
                                                <i class="fas fa-phone-alt"></i>
                                            </a>
                                        </c:if>
                                    </div>

                                    <div class="flex items-start p-3 bg-gray-50 rounded-lg">
                                        <div class="w-8 h-8 bg-orange-100 rounded-full flex items-center justify-center mr-3 mt-1">
                                            <i class="fas fa-map-marker-alt text-orange-600 text-sm"></i>
                                        </div>
                                        <div class="flex-1">
                                            <label class="text-sm font-medium text-gray-600">Địa chỉ</label>
                                            <p class="text-gray-900 font-semibold">
                                                <c:choose>
                                                    <c:when test="${not empty user.address}">
                                                        ${user.address}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-400 italic">Chưa cập nhật</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Account Statistics (Optional) -->
                        <div class="mt-8 pt-6 border-t border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-800 mb-4">
                                <i class="fas fa-chart-bar text-indigo-600 mr-2"></i>
                                Thống kê tài khoản
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div class="bg-blue-50 p-4 rounded-lg text-center">
                                    <div class="text-2xl font-bold text-blue-600">0</div>
                                    <div class="text-sm text-blue-600">Đơn hàng</div>
                                </div>
                                <div class="bg-green-50 p-4 rounded-lg text-center">
                                    <div class="text-2xl font-bold text-green-600">0</div>
                                    <div class="text-sm text-green-600">Sản phẩm yêu thích</div>
                                </div>
                                <div class="bg-purple-50 p-4 rounded-lg text-center">
                                    <div class="text-2xl font-bold text-purple-600">
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <div class="text-sm text-purple-600">Ngày đăng ký</div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="mt-8 pt-6 border-t border-gray-200 flex flex-col sm:flex-row gap-3 justify-center">
                            <a href="/admin/user/${id}/edit" 
                               class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-edit mr-2"></i>
                                Chỉnh sửa thông tin
                            </a>
                            <button onclick="confirmDelete({id})" 
                                     href = "/admin/user/delete/"
                                    class="inline-flex items-center justify-center px-6 py-3 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-trash mr-2"></i>
                                Xóa người dùng
                            </button>
                            <a href="/admin/user" 
                               class="inline-flex items-center justify-center px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white font-medium rounded-lg transition duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-list mr-2"></i>
                                Danh sách người dùng
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center">
        <div class="bg-white rounded-lg p-6 max-w-md mx-4">
            <div class="text-center">
                <i class="fas fa-exclamation-triangle text-red-600 text-4xl mb-4"></i>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Xác nhận xóa</h3>
                <p class="text-gray-600 mb-6">Bạn có chắc chắn muốn xóa người dùng này? Hành động này không thể hoàn tác.</p>
                <div class="flex justify-center space-x-3">
                    <button onclick="hideDeleteModal()" 
                            class="px-4 py-2 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-lg transition">
                        Hủy
                    </button>
                    <button onclick="deleteUser()" 
                            class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg transition"
                           >
                        Xóa
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let userIdToDelete = null;

        function confirmDelete(userId) {
            userIdToDelete = userId;
            document.getElementById('deleteModal').classList.remove('hidden');
        }

        function hideDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
            userIdToDelete = null;
        }

        function deleteUser() {
            if (userIdToDelete) {
                // Redirect to delete endpoint
                window.location.href = `/admin/user/${userIdToDelete}/delete`;
            }
        }

        // Close modal when clicking outside
        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideDeleteModal();
            }
        });
    </script>
</body>

</html>