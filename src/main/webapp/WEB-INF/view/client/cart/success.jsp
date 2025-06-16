<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-green-50 font-sans">
    <div class="min-h-screen flex flex-col justify-center items-center">
        <div class="bg-white shadow-lg rounded-lg p-10 text-center max-w-xl">
            <svg class="w-16 h-16 mx-auto text-green-500 mb-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"></path>
            </svg>
            <h1 class="text-3xl font-bold text-green-700 mb-3">Đặt hàng thành công!</h1>
            <p class="text-gray-700 mb-6">Cảm ơn bạn đã mua hàng tại <strong>ShopPhone</strong>. Đơn hàng của bạn đang được xử lý và sẽ sớm được giao.</p>
            <div class="flex justify-center space-x-4">
                <a href="/product" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">Tiếp tục mua sắm</a>
                <a href="/homepage/cart" class="bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-4 rounded">Xem đơn hàng</a>
            </div>
        </div>
    </div>
</body>
</html>
