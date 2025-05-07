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

        .btn-danger {
            background-color: var(--danger);
            border-color: var(--danger);
        }

        .btn-danger:hover {
            background-color: #D32F2F;
            border-color: #D32F2F;
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

        /* Checkbox styles */
        .form-check-input {
            width: 20px;
            height: 20px;
            margin-top: 0;
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

        /* Book management specific styles */
        .add-book-row {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .add-book-row .form-control {
            margin-bottom: 10px;
        }

        .available-checkbox {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
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
                    <a class="nav-link" href="#">
                        <i class="fas fa-book"></i> Books
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp" method="POST">
                        <i class="fas fa-sign-out-alt"></i> Home
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header-bar fade-in">
            <h5 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>Book Management Dashboard</h5>
            <div class="user-profile">
                <div class="user-avatar">${currentUser.name.charAt(0)}</div>
                <div>
                    <div class="fw-bold">${currentUser.name}</div>
                    <div class="text-muted small">Admin</div>
                </div>
            </div>
        </div>

        <!-- Book Management Section -->
        <div class="dashboard-card fade-in">
            <div class="card-header">
                <span><i class="fas fa-book me-2"></i>Book Management</span>
            </div>
            <div class="card-body">
                <!-- Add New Book Form -->
                <div class="add-book-row mb-4">
                    <h5><i class="fas fa-plus-circle me-2"></i> Add New Book</h5>
                    <form id="add-book-form" onsubmit="return addBook();" class="row g-3">
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="new-title" placeholder="Title" required>
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="new-author" placeholder="Author" required>
                        </div>
                        <div class="col-md-1">
                            <input type="number" class="form-control" id="new-price" placeholder="Price" required step="0.01">
                        </div>
                        <div class="col-md-1">
                            <input type="number" class="form-control" id="new-stock" placeholder="Stock" required>
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="new-genres" placeholder="Genres (comma-separated)" required>
                        </div>
                        <div class="col-md-1">
                            <div class="form-check available-checkbox">
                                <input class="form-check-input" type="checkbox" id="new-available">
                                <label class="form-check-label ms-2" for="new-available">Available</label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-plus me-2"></i>Add Book
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Books Table -->
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price ($)</th>
                            <th>Stock</th>
                            <th class="text-center">Available</th>
                            <th>Genres</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="book-table-body">
                        <!-- Rows will be loaded here dynamically -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    // Initialize Toastr
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "timeOut": "3000"
    };

    async function loadBooks() {
        try {
            const response = await fetch('books');
            const books = await response.json();

            const tableBody = document.getElementById('book-table-body');
            tableBody.innerHTML = "";

            books.forEach(book => {
                const row = document.createElement('tr');

                // Title Cell
                const titleCell = document.createElement('td');
                const titleInput = document.createElement('input');
                titleInput.type = 'text';
                titleInput.className = 'form-control form-control-sm';
                titleInput.value = book.title;
                titleInput.onchange = () => updateValue(titleInput, book.bookId, 'title');
                titleCell.appendChild(titleInput);

                // Author Cell
                const authorCell = document.createElement('td');
                const authorInput = document.createElement('input');
                authorInput.type = 'text';
                authorInput.className = 'form-control form-control-sm';
                authorInput.value = book.author;
                authorInput.onchange = () => updateValue(authorInput, book.bookId, 'author');
                authorCell.appendChild(authorInput);

                // Price Cell
                const priceCell = document.createElement('td');
                const priceInput = document.createElement('input');
                priceInput.type = 'number';
                priceInput.className = 'form-control form-control-sm';
                priceInput.value = book.bookPrice;
                priceInput.step = "0.01";
                priceInput.onchange = () => updateValue(priceInput, book.bookId, 'bookPrice');
                priceCell.appendChild(priceInput);

                // Stock Cell
                const stockCell = document.createElement('td');
                const stockInput = document.createElement('input');
                stockInput.type = 'number';
                stockInput.className = 'form-control form-control-sm';
                stockInput.value = book.stock;
                stockInput.onchange = () => updateValue(stockInput, book.bookId, 'stock');
                stockCell.appendChild(stockInput);

                // Available Cell
                const availableCell = document.createElement('td');
                availableCell.className = 'text-center';
                const availableCheckbox = document.createElement('input');
                availableCheckbox.type = 'checkbox';
                availableCheckbox.className = 'form-check-input';
                availableCheckbox.checked = book.available;
                availableCheckbox.onchange = () => updateCheckbox(book.bookId, 'available', availableCheckbox.checked);
                availableCell.appendChild(availableCheckbox);

                // Genres Cell
                const genresCell = document.createElement('td');
                genresCell.textContent = book.genres.join(", ");

                // Actions Cell
                const actionsCell = document.createElement('td');
                const deleteButton = document.createElement('button');
                deleteButton.className = 'btn btn-sm btn-danger';
                deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
                deleteButton.onclick = () => deleteBook(book.bookId);
                actionsCell.appendChild(deleteButton);

                // Append all cells to row
                row.appendChild(titleCell);
                row.appendChild(authorCell);
                row.appendChild(priceCell);
                row.appendChild(stockCell);
                row.appendChild(availableCell);
                row.appendChild(genresCell);
                row.appendChild(actionsCell);

                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error("Error loading books:", error);
            toastr.error("Failed to load books");
        }
    }

    async function deleteBook(bookId) {
        const confirmed = confirm("Are you sure you want to delete this book?");
        if (!confirmed) return;

        try {
            await fetch('books?code=' + bookId, {
                method: 'DELETE'
            });
            toastr.success('Book deleted successfully');
            loadBooks();
        } catch (error) {
            console.error("Error deleting book:", error);
            toastr.error("Failed to delete book");
        }
    }

    async function updateCheckbox(bookId, field, value) {
        try {
            const res = await fetch('books?code=' + bookId);
            const book = await res.json();

            book[field] = value;

            await fetch('books', {
                method: 'PUT',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(book)
            });

            toastr.success('Book updated successfully');
            loadBooks();
        } catch (error) {
            console.error("Error updating checkbox:", error);
            toastr.error("Failed to update book");
        }
    }

    async function addBook() {
        try {
            const title = document.getElementById('new-title').value;
            const author = document.getElementById('new-author').value;
            const price = parseFloat(document.getElementById('new-price').value);
            const stock = parseInt(document.getElementById('new-stock').value);
            const available = document.getElementById('new-available').checked;
            const genresStr = document.getElementById('new-genres').value;
            const genres = genresStr.split(',').map(g => g.trim()).filter(g => g.length > 0);

            const newBook = {
                title,
                author,
                bookPrice: price,
                stock,
                available,
                genres
            };

            await fetch('books', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(newBook)
            });

            document.getElementById('add-book-form').reset();
            toastr.success('Book added successfully');
            loadBooks();
        } catch (error) {
            console.error("Error adding book:", error);
            toastr.error("Failed to add book");
        }
        return false;
    }

    async function updateValue(input, bookId, field) {
        try {
            const res = await fetch('books?code=' + bookId);
            const book = await res.json();
            book[field] = input.type === "number" ? parseFloat(input.value) : input.value;
            if (typeof book.available !== 'boolean') {
                book.available = false;
            }

            if (!Array.isArray(book.genres)) {
                book.genres = [];
            }

            const response = await fetch('books', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(book)
            });

            if (!response.ok) {
                throw new Error('Update failed');
            }

            toastr.success('Book updated successfully');
            loadBooks();
        } catch (error) {
            console.error("Error updating value:", error);
            toastr.error("Failed to update book");
        }
    }

    window.onload = loadBooks;
</script>
</body>
</html>