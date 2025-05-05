<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Cập nhật người dùng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="max-w-xl mx-auto mt-12 bg-white p-8 rounded-xl shadow-md">
    <h2 class="text-2xl font-bold mb-6 text-center text-blue-600">Cập nhật người dùng</h2>

    <form:form action="/admin/user/update" method="post" modelAttribute="currentUser" cssClass="space-y-5">
        <form:hidden path="id"/>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <form:input path="email" cssClass="w-full px-4 py-2 border rounded-md bg-gray-100 cursor-not-allowed" disabled="true"/>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Họ tên</label>
            <form:input path="name" cssClass="w-full px-4 py-2 border rounded-md" />
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
            <form:input path="address" cssClass="w-full px-4 py-2 border rounded-md" />
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
            <form:input path="phone" cssClass="w-full px-4 py-2 border rounded-md" />
        </div>

        <div class="flex justify-between pt-4">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">Cập nhật</button>
            <a href="/admin/user" class="bg-gray-400 hover:bg-gray-500 text-white px-4 py-2 rounded-md">Quay lại</a>
        </div>
    </form:form>
</div>

</body>
</html>
