<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    	<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin-User</title>
        </head>
        <body>
            <h1>Danh sách User</h1>
		    <table border="1">
		        <tr>
		            <th>ID</th>
		            <th>Tên User</th>
		            <th>Role</th>
		            <th>Địa chỉ</th>
		        </tr>
		        <c:forEach var="user" items="${users}">
		            <tr>
		                <td>${user.id}</td>
		                <td>${user.name}</td>
		                <td>${user.role}</td>
		                <td>${user.address}</td>
		            </tr>
		        </c:forEach>
		    </table>
        </body>
        </html>

        