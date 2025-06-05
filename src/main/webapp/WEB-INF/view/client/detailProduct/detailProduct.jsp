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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>DetailProduct</title>
</head>
<body>
    <div>
        <jsp:include page="../layout/layout.jsp" />
<div id="searchModal" class="fixed inset-0 z-50 hidden overflow-y-auto bg-black bg-opacity-50" tabindex="-1">
    <div class="flex items-center justify-center min-h-screen">
      <div class="bg-white w-full h-full max-w-7xl p-4 rounded-none">
        <div class="flex justify-between items-center border-b pb-2">
          <h5 class="text-lg font-semibold">Search by keyword</h5>
          <button class="text-gray-500 hover:text-black" onclick="document.getElementById('searchModal').classList.add('hidden')">
            &times;
          </button>
        </div>
        <div class="flex items-center justify-center py-6">
          <div class="flex w-3/4 mx-auto">
            <input type="search" class="w-full px-4 py-3 border rounded-l-md" placeholder="keywords">
            <span class="inline-flex items-center px-4 py-3 bg-gray-200 rounded-r-md">
              <i class="fa fa-search"></i>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="py-10 bg-gray-50">
    <div class="container mx-auto px-4">
      <div class="flex flex-col lg:flex-row gap-8">
        <div class="w-full lg:w-3/4">
          <div class="flex flex-col md:flex-row gap-6">
            <div class="md:w-1/2">
              <div class="border rounded overflow-hidden">
                <img src="/images/products/${product.image}" class="w-full object-cover" alt="Image">
              </div>
            </div>
            <div class="md:w-1/2">
              <h4 class="text-2xl font-bold mb-2">${product.name}</h4>
              
              <h5 class="text-xl font-bold text-red-600 mb-3">
                <fmt:formatNumber type="number" value="${product.price}" /> VND
              </h5>
              <div class="flex text-yellow-400 mb-3">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star text-gray-300"></i>
              </div>
              <p class="mb-4">${product.shortDesc}</p>
              <div class="flex items-center space-x-2 mb-4">
                <button class="w-8 h-8 border rounded-full">-</button>
                <input type="text" class="w-12 text-center border rounded" value="1" data-cart-detail-index="0">
                <button class="w-8 h-8 border rounded-full">+</button>
              </div>
              <form method="post" action="/add-product-from-view-detail/${product.id}" modelAttribute="product">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="text" name="id" class="hidden" value="${product.id}">
                <input type="text" name="quantity" class="hidden" id="cartDetails0.quantity">
                <button class="flex items-center gap-2 border border-gray-400 px-4 py-2 rounded-full text-blue-600">
                  <i class="fa fa-shopping-bag"></i> Add to cart
                </button>
              </form>
            </div>
          </div>
  
          <div class="mt-8">
            <div class="border-b pb-2 mb-4">
              <button class="font-semibold text-lg">Description</button>
            </div>
            <p></p>
          </div>
        </div>
  
        <div class="w-full lg:w-1/4">
          <div class="mb-4">
            <div class="flex w-full mb-4">
              <input type="search" class="w-full px-4 py-3 border rounded-l-md" placeholder="keywords">
              <span class="inline-flex items-center px-4 py-3 bg-gray-200 rounded-r-md">
                <i class="fa fa-search"></i>
              </span>
            </div>
          </div>
  
          <div>
            <h4 class="text-xl font-semibold mb-3">Categories</h4>
            <ul class="space-y-2">
              <li class="flex justify-between">
                <a href="#" class="hover:text-red-500"><i class="fas fa-apple-alt mr-2"></i>APPLE</a>
                <span>(3)</span>
              </li>
              <li class="flex justify-between">
                <a href="#" class="hover:text-red-500"><i class="fas fa-apple-alt mr-2"></i>HP</a>
                <span>(5)</span>
              </li>
              <li class="flex justify-between">
                <a href="#" class="hover:text-red-500"><i class="fas fa-apple-alt mr-2"></i>ASUS</a>
                <span>(2)</span>
              </li>
              <li class="flex justify-between">
                <a href="#" class="hover:text-red-500"><i class="fas fa-apple-alt mr-2"></i>LENOVO</a>
                <span>(8)</span>
              </li>
              <li class="flex justify-between">
                <a href="#" class="hover:text-red-500"><i class="fas fa-apple-alt mr-2"></i>DELL</a>
                <span>(5)</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
    </div>
</body>
</html>