<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Book Master</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <style>
        :root {
            --primary: #5D5FEF;
            --primary-light: #E0E1FF;
            --secondary: #FF8A00;
            --success: #4CAF50;
            --info: #2196F3;
            --warning: #FFC107;
            --danger: #F44336;
            --dark: #1A1A1A;
            --light: #F8F9FA;
            --sidebar: #2C3E50;
            --sidebar-hover: #34495E;
        }

        body {
            background-color: #F5F7FB;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            background-color: var(--sidebar);
            color: white;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin: 5px 0;
            border-radius: 0 30px 30px 0;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }

        .nav-link:hover, .nav-link.active {
            background-color: var(--sidebar-hover);
            color: white;
            transform: translateX(5px);
        }

        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            padding: 20px;
        }

        .header-bar {
            background-color: white;
            border-radius: 10px;
            padding: 15px 25px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            font-weight: bold;
        }

        /* Card Styles */
        .dashboard-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            overflow: hidden;
            border: none;
        }

        .card-header {
            background-color: white;
            color: var(--dark);
            padding: 18px 25px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            font-weight: 600;
            font-size: 1.1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header i {
            color: var(--primary);
            margin-right: 8px;
        }

        .card-body {
            padding: 25px;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
        }

        .stat-info {
            flex: 1;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 5px 0;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        /* Table Styles */
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background-color: #F8FAFC;
            padding: 15px;
            font-weight: 600;
            color: #4A5568;
            border-bottom: 1px solid #EDF2F7;
        }

        .table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #EDF2F7;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .table tr:hover {
            background-color: #F8FAFC;
        }

        /* Badge Styles */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.75rem;
        }

        .badge-primary {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .badge-success {
            background-color: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .badge-warning {
            background-color: rgba(255, 193, 7, 0.1);
            color: #FFA000;
        }

        .badge-danger {
            background-color: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .badge-info {
            background-color: rgba(33, 150, 243, 0.1);
            color: var(--info);
        }

        /* Button Styles */
        .btn {
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: #4A4CDB;
            border-color: #4A4CDB;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(93, 95, 239, 0.2);
        }

        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary);
        }

        /* Form Styles */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #E2E8F0;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(93, 95, 239, 0.25);
        }

        /* Search Box */
        .search-box {
            margin-bottom: 20px;
        }

        .search-box .input-group {
            max-width: 400px;
        }

        /* Modal Styles */
        .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .modal-header {
            background-color: var(--primary);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 15px 20px;
        }

        .modal-title {
            font-weight: 600;
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4 class="text-center"><i class="fas fa-book-open me-2"></i>Book Master</h4>
        </div>
        <div class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#books-section">
                        <i class="fas fa-book"></i> Books
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#users-section">
                        <i class="fas fa-users"></i> Users
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#orders-section">
                        <i class="fas fa-shopping-cart"></i> Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#inventory-section">
                        <i class="fas fa-boxes"></i> Inventory
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#reports-section">
                        <i class="fas fa-chart-bar"></i> Reports
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link" href="logout" method="POST">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header-bar fade-in">
            <h5 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard</h5>
            <div class="user-profile">
                <div class="user-avatar">${currentUser.name.charAt(0)}</div>
                <div>
                    <div class="fw-bold">${currentUser.name}</div>
                    <div class="text-muted small">Admin</div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-container fade-in">
            <div class="stat-card">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-info">
                    <div class="stat-value text-primary">${inventoryStats.totalBooks}</div>
                    <div class="stat-label">Total Books</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-success bg-opacity-10 text-success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <div class="stat-value text-success">${inventoryStats.inStock}</div>
                    <div class="stat-label">In Stock</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="stat-info">
                    <div class="stat-value text-warning">${inventoryStats.lowStock}</div>
                    <div class="stat-label">Low Stock</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bg-danger bg-opacity-10 text-danger">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <div class="stat-value text-danger">${inventoryStats.outOfStock}</div>
                    <div class="stat-label">Out of Stock</div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mb-4 fade-in">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <div class="card-header">
                        <span><i class="fas fa-bolt me-2"></i>Quick Actions</span>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                                <i class="fas fa-plus me-2"></i>Add Book
                            </button>
                            <button class="btn btn-outline-primary">
                                <i class="fas fa-file-import me-2"></i>Import Books
                            </button>
                            <button class="btn btn-outline-primary">
                                <i class="fas fa-file-export me-2"></i>Export Data
                            </button>
                            <button class="btn btn-outline-primary">
                                <i class="fas fa-bell me-2"></i>View Alerts
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Books Section -->
        <div class="dashboard-card fade-in" id="books-section">
            <div class="card-header">
                <span><i class="fas fa-book me-2"></i>Book Management</span>
                <div class="search-box">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search books..." id="bookSearch">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cover</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Genre</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td>${book.bookId}</td>
                                <td>
                                    <div class="bg-light rounded" style="width: 40px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-book text-muted"></i>
                                    </div>
                                </td>
                                <td class="fw-bold">${book.title}</td>
                                <td>${book.author}</td>
                                <td>
                                    <c:forEach var="genre" items="${book.genres}">
                                        <span class="badge bg-primary bg-opacity-10 text-primary me-1">${genre.genreName}</span>
                                    </c:forEach>
                                </td>
                                <td class="fw-bold">$${book.bookPrice}</td>
                                <td>
                                    <form class="d-inline update-stock-form" data-bookid="${book.bookId}">
                                        <div class="input-group input-group-sm" style="width: 100px;">
                                            <input type="number" value="${book.stock}" class="form-control" name="newStock">
                                            <button class="btn btn-outline-primary" type="submit">
                                                <i class="fas fa-save"></i>
                                            </button>
                                        </div>
                                    </form>
                                </td>
                                <td>
                                    <span class="badge ${book.stock > 5 ? 'badge-success' : book.stock > 0 ? 'badge-warning' : 'badge-danger'}">
                                            ${book.stock > 5 ? 'In Stock' : book.stock > 0 ? 'Low Stock' : 'Out of Stock'}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary edit-book" data-bookid="${book.bookId}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger delete-book" data-bookid="${book.bookId}">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Users and Orders Section -->
        <div class="row fade-in">
            <div class="col-md-6">
                <div class="dashboard-card" id="users-section">
                    <div class="card-header">
                        <span><i class="fas fa-users me-2"></i>User Management</span>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Type</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.customerId}</td>
                                        <td>${user.name}</td>
                                        <td>${user.email}</td>
                                        <td>
                                            <span class="badge ${user.userType == 'admin' ? 'badge-primary' : 'badge-info'}">
                                                    ${user.userType}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <c:if test="${user.userType != 'admin'}">
                                                    <button class="btn btn-sm btn-outline-success make-admin" data-userid="${user.customerId}">
                                                        <i class="fas fa-user-shield"></i>
                                                    </button>
                                                </c:if>
                                                <button class="btn btn-sm btn-outline-danger delete-user" data-userid="${user.customerId}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="dashboard-card" id="orders-section">
                    <div class="card-header">
                        <span><i class="fas fa-shopping-cart me-2"></i>Recent Orders</span>
                        <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="order" items="${recentOrders}">
                                    <tr>
                                        <td class="fw-bold">#${order.orderId}</td>
                                        <td>${order.customerName}</td>
                                        <td class="fw-bold">$${order.totalPrice}</td>
                                        <td>
                                            <span class="badge ${order.orderStatus == 'Shipped' ? 'badge-success' :
                                                  order.orderStatus == 'Processing' ? 'badge-warning' : 'badge-danger'}">
                                                    ${order.orderStatus}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i> Add New Book</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="addBookForm" action="addBook" method="POST" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Title <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Author <span class="text-danger">*</span></label>
                                <input type="text" name="author" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Price <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" name="price" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Stock Quantity <span class="text-danger">*</span></label>
                                <input type="number" name="stock" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Genre <span class="text-danger">*</span></label>
                                <select name="genre" class="form-select" required>
                                    <option value="">Select Genre</option>
                                    <c:forEach var="genre" items="${genres}">
                                        <option value="${genre.genreId}">${genre.genreName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Book Cover</label>
                                <input type="file" name="coverImage" class="form-control" accept="image/*">
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" name="isAvailable" id="isAvailable" checked>
                                <label class="form-check-label" for="isAvailable">Available for purchase</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Book Modal (Dynamic content will be loaded here) -->
<div class="modal fade" id="editBookModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-edit me-2"></i> Edit Book</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editBookForm" action="updateBook" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="bookId" id="editBookId">
                <div class="modal-body" id="editBookModalBody">
                    <!-- Content will be loaded via AJAX -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    $(document).ready(function() {
        // Initialize Toastr
        toastr.options = {
            "closeButton": true,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "timeOut": "3000"
        };

        // Real-time stock updates
        $('.update-stock-form').on('submit', function(e) {
            e.preventDefault();
            const form = $(this);
            const bookId = form.data('bookid');
            const newStock = form.find('input[name="newStock"]').val();

            $.ajax({
                url: 'updateStock',
                method: 'POST',
                data: { bookId: bookId, newStock: newStock },
                success: function(response) {
                    toastr.success('Stock updated successfully');
                    // Update status badge
                    const badge = form.closest('tr').find('.badge');
                    badge.removeClass('badge-success badge-warning badge-danger');

                    if(newStock > 5) {
                        badge.addClass('badge-success').text('In Stock');
                    } else if(newStock > 0) {
                        badge.addClass('badge-warning').text('Low Stock');
                    } else {
                        badge.addClass('badge-danger').text('Out of Stock');
                    }
                },
                error: function() {
                    toastr.error('Error updating stock');
                }
            });
        });

        // Make user admin
        $('.make-admin').click(function() {
            const userId = $(this).data('userid');
            const button = $(this);

            if(confirm('Are you sure you want to make this user an admin?')) {
                $.ajax({
                    url: 'makeAdmin',
                    method: 'POST',
                    data: { userId: userId },
                    success: function(response) {
                        toastr.success('User promoted to admin');
                        // Update the UI without reloading
                        button.closest('tr').find('.badge')
                            .removeClass('badge-info')
                            .addClass('badge-primary')
                            .text('admin');
                        button.remove();
                    },
                    error: function() {
                        toastr.error('Error promoting user');
                    }
                });
            }
        });

        // Delete book
        $('.delete-book').click(function() {
            const bookId = $(this).data('bookid');
            const row = $(this).closest('tr');

            if(confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                $.ajax({
                    url: 'deleteBook',
                    method: 'POST',
                    data: { bookId: bookId },
                    success: function(response) {
                        toastr.success('Book deleted successfully');
                        row.fadeOut(300, function() {
                            $(this).remove();
                        });
                    },
                    error: function() {
                        toastr.error('Error deleting book');
                    }
                });
            }
        });

        // Delete user
        $('.delete-user').click(function() {
            const userId = $(this).data('userid');
            const row = $(this).closest('tr');

            if(confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                $.ajax({
                    url: 'deleteUser',
                    method: 'POST',
                    data: { userId: userId },
                    success: function(response) {
                        toastr.success('User deleted successfully');
                        row.fadeOut(300, function() {
                            $(this).remove();
                        });
                    },
                    error: function() {
                        toastr.error('Error deleting user');
                    }
                });
            }
        });

        // Book search
        $('#bookSearch').keyup(function() {
            const searchText = $(this).val().toLowerCase();
            $('table tbody tr').each(function() {
                const rowText = $(this).text().toLowerCase();
                $(this).toggle(rowText.indexOf(searchText) > -1);
            });
        });

        // Edit book modal
        $('.edit-book').click(function() {
            const bookId = $(this).data('bookid');

            $.ajax({
                url: 'getBookDetails',
                method: 'GET',
                data: { bookId: bookId },
                success: function(response) {
                    $('#editBookId').val(bookId);
                    $('#editBookModalBody').html(response);
                    $('#editBookModal').modal('show');
                },
                error: function() {
                    toastr.error('Error loading book details');
                }
            });
        });

        // Handle edit form submission
        $('#editBookForm').on('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                url: 'updateBook',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    toastr.success('Book updated successfully');
                    $('#editBookModal').modal('hide');
                    setTimeout(() => location.reload(), 1000);
                },
                error: function() {
                    toastr.error('Error updating book');
                }
            });
        });
    });
</script>
</body>
</html>