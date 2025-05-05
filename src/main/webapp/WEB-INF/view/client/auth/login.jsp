<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - LaptopShop</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-blue-500">
    <div class="w-full max-w-md">
        <div class="bg-white shadow-md rounded-lg p-8">
            <h2 class="text-2xl font-bold text-center mb-6">Login</h2>
            <form method="post" action="/login">
                <c:if test="${param.error != null}">
                    <div class="text-red-600 text-sm mb-4">Invalid email or password</div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="text-green-600 text-sm mb-4">Logout success</div>
                </c:if>

                <div class="mb-4">
                    <label for="inputEmail" class="block text-gray-700">Email address</label>
                    <input class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" 
                        id="inputEmail" type="email" name="username" placeholder="name@example.com" />
                </div>

                <div class="mb-4">
                    <label for="inputPassword" class="block text-gray-700">Password</label>
                    <input class="w-full px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-400" 
                        id="inputPassword" type="password" name="password" placeholder="Password" />
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="mt-6">
                    <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded">
                        Login
                    </button>
                </div>
            </form>

            <div class="mt-4 text-center">
                <a href="/register" class="text-blue-600 hover:underline text-sm">Need an account? Sign up!</a>
            </div>
        </div>
    </div>
</body>

</html>
