<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books | Book Haven</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #5D5FEF;
            --primary-light: #E0E1FF;
            --sidebar: #2C3E50;
            --sidebar-hover: #34495E;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F5F7FB;
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

        .search-box {
            max-width: 500px;
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
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

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.75rem;
        }

        .badge-success {
            background-color: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
        }

        .badge-warning {
            background-color: rgba(255, 193, 7, 0.1);
            color: #FFA000;
        }

        .badge-danger {
            background-color: rgba(244, 67, 54, 0.1);
            color: #F44336;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4 class="text-center"><i class="fas fa-book-open me-2"></i>Book Haven</h4>
        </div>
        <div class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="browse.jsp">
                        <i class="fas fa-book"></i> Browse Books
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header-bar">
            <h5 class="mb-0"><i class="fas fa-book me-2"></i>Browse Books</h5>
            <div class="search-box">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search by title or author..." id="searchInput">
                    <button class="btn btn-primary" type="button" id="searchButton">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </div>
        </div>

        <!-- Books Table - Initially hidden -->
        <div class="card" id="resultsCard" style="display: none;">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Genres</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="bookTableBody">
                        <!-- Books will be loaded here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Empty state - shown initially -->
        <div class="card" id="emptyState">
            <div class="card-body empty-state">
                <i class="fas fa-search fa-3x mb-3"></i>
                <h4>Search for Books</h4>
                <p class="text-muted">Enter a book title or author name in the search box above</p>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        // Search button click handler
        $('#searchButton').click(function() {
            const searchTerm = $('#searchInput').val().trim();
            if (searchTerm) {
                searchBooks(searchTerm);
            } else {
                showEmptyState();
            }
        });

        // Enter key in search input
        $('#searchInput').keypress(function(e) {
            if (e.which === 13) {
                const searchTerm = $('#searchInput').val().trim();
                if (searchTerm) {
                    searchBooks(searchTerm);
                } else {
                    showEmptyState();
                }
            }
        });
    });

    function searchBooks(searchTerm) {
        // Show loading state
        $('#emptyState').hide();
        $('#resultsCard').show();
        $('#bookTableBody').html('<tr><td colspan="7" class="text-center">Searching... <i class="fas fa-spinner fa-spin"></i></td></tr>');

        // Make AJAX request to search endpoint
        $.ajax({
            url: 'books?search=' + encodeURIComponent(searchTerm),
            method: 'GET',
            dataType: 'json',
            success: function(books) {
                displayBooks(books);
            },
            error: function(xhr, status, error) {
                console.error('Error searching books:', error);
                $('#bookTableBody').html('<tr><td colspan="7" class="text-center text-danger">Error searching books. Please try again.</td></tr>');
            }
        });
    }

    function displayBooks(books) {
        const tableBody = $('#bookTableBody');
        tableBody.empty();

        if (books.length === 0) {
            tableBody.html('<tr><td colspan="7" class="text-center text-muted">No books found matching your search.</td></tr>');
            return;
        }

        books.forEach(book => {
            // Determine stock status
            let statusBadge, statusClass;
            if (book.stock > 5) {
                statusBadge = 'In Stock';
                statusClass = 'badge-success';
            } else if (book.stock > 0) {
                statusBadge = 'Low Stock';
                statusClass = 'badge-warning';
            } else {
                statusBadge = 'Out of Stock';
                statusClass = 'badge-danger';
            }

            // Get genres (assuming book.genres is an array)
            const genres = book.genres ? book.genres.join(', ') : 'Not specified';

            const row = `
                <tr>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>$${book.bookPrice.toFixed(2)}</td>
                    <td>${book.stock}</td>
                    <td><span class="badge ${statusClass}">${statusBadge}</span></td>
                    <td>${genres}</td>
                    <td>
                        <button class="btn btn-primary btn-sm add-to-cart"
                                ${book.stock <= 0 ? 'disabled' : ''}
                                data-id="${book.bookId}"
                                data-title="${book.title}">
                            <i class="fas fa-cart-plus"></i> Add to Cart
                        </button>
                    </td>
                </tr>
            `;
            tableBody.append(row);
        });

        // Add event listeners to Add to Cart buttons
        $('.add-to-cart').click(function() {
            const bookId = $(this).data('id');
            const title = $(this).data('title');
            addToCart(bookId, title);
        });
    }

    function showEmptyState() {
        $('#resultsCard').hide();
        $('#emptyState').show();
    }

    function addToCart(bookId, title) {
        // Here you would implement your actual cart adding logic
        // For now, just showing an alert
        alert(`"${title}" (ID: ${bookId}) added to cart`);

        // In a real implementation, you would:
        // 1. Make an AJAX call to your cart endpoint
        // 2. Update the UI to reflect the cart change
        // 3. Show a success notification
    }
</script>
</body>
</html>