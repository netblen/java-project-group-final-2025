<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Master - Your Literary Book Bestie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }

        body {
            font-family: 'Georgia', serif;
            background-color: #f9f5f0;
        }

        .navbar-brand {
            font-family: 'Times New Roman', serif;
            font-weight: bold;
            font-size: 1.8rem;
        }

        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('images/bookshelf-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 6rem 0;
            margin-bottom: 3rem;
        }

        .book-card {
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
            height: 100%;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Book Master</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="browse.jsp">Browse</a>
                </li>

            </ul>
            <ul class="navbar-nav">
                <%
                    com.example.project.model.Customer currentUser = (com.example.project.model.Customer) session.getAttribute("currentUser");
                    if (currentUser != null) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-user"></i> Welcome, <%= currentUser.getName() %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
                <%
                } else {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
                </li>
                <%
                    }
                %>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart <span class="badge bg-primary">0</span></a>
                </li>
            </ul>

        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold mb-4">Discover Your Next Favorite Book</h1>
        <p class="lead mb-5">Explore our vast collection of literary treasures from around the world</p>
        <form class="row g-3 justify-content-center">
            <div class="col-md-8">
                <div class="input-group">
                    <input type="text" class="form-control form-control-lg" placeholder="Search by title, author, or genre...">
                    <button class="btn btn-primary btn-lg" type="submit"><i class="fas fa-search"></i> Search</button>
                </div>
            </div>
        </form>
    </div>
</section>

<!-- Featured Books -->
<section class="container mb-5">
    <h2 class="text-center mb-4">Featured Books</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card book-card">
                <img src="images/Alex.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h5 class="card-title">The Silent Patient</h5>
                    <p class="card-text text-muted">Alex Michaelides</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-primary">Thriller</span>
                        <h5 class="text-primary mb-0">$12.99</h5>
                    </div>
                    <div class="mt-3 d-grid gap-2">
                        <button class="btn btn-outline-primary">View Details</button>
                        <button class="btn btn-primary">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card book-card">
                <img src="images/tara.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h5 class="card-title">Educated</h5>
                    <p class="card-text text-muted">Tara Westover</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-success">Memoir</span>
                        <h5 class="text-primary mb-0">$14.99</h5>
                    </div>
                    <div class="mt-3 d-grid gap-2">
                        <button class="btn btn-outline-primary">View Details</button>
                        <button class="btn btn-primary">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card book-card">
                <img src="images/andy.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h5 class="card-title">Project Hail Mary</h5>
                    <p class="card-text text-muted">Andy Weir</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-info">Sci-Fi</span>
                        <h5 class="text-primary mb-0">$15.99</h5>
                    </div>
                    <div class="mt-3 d-grid gap-2">
                        <button class="btn btn-outline-primary">View Details</button>
                        <button class="btn btn-primary">Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="text-center mt-4">
        <a href="browse.jsp" class="btn btn-outline-dark btn-lg">View All Books</a>
    </div>
</section>

<%--<!-- Features Section -->--%>
<%--<section class="bg-light py-5">--%>
<%--    <div class="container">--%>
<%--        <h2 class="text-center mb-5">Why Choose Book Master?</h2>--%>
<%--        <div class="row text-center">--%>
<%--            <div class="col-md-4 mb-4">--%>
<%--                <div class="feature-icon">--%>
<%--                    <i class="fas fa-book-open"></i>--%>
<%--                </div>--%>
<%--                <h4>Vast Collection</h4>--%>
<%--                <p>Thousands of books across all genres to satisfy every reader's taste.</p>--%>
<%--            </div>--%>
<%--            <div class="col-md-4 mb-4">--%>
<%--                <div class="feature-icon">--%>
<%--                    <i class="fas fa-truck"></i>--%>
<%--                </div>--%>
<%--                <h4>Fast Delivery</h4>--%>
<%--                <p>Get your books delivered to your doorstep in just 2-3 business days.</p>--%>
<%--            </div>--%>
<%--            <div class="col-md-4 mb-4">--%>
<%--                <div class="feature-icon">--%>
<%--                    <i class="fas fa-headset"></i>--%>
<%--                </div>--%>
<%--                <h4>24/7 Support</h4>--%>
<%--                <p>Our customer service team is always ready to assist you.</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</section>--%>
<section class="container mb-5">
    <h2 class="text-center mb-4">Featured Books</h2>
    <div class="row" id="featured-books">
        <!-- Books will be injected here by JavaScript -->
    </div>
    <div class="text-center mt-4">
        <a href="browse.jsp" class="btn btn-outline-dark btn-lg">View All Books</a>
    </div>
</section>

<!-- Bestsellers Section -->
<section class="container py-5">
    <h2 class="text-center mb-5">Bestsellers</h2>
    <div class="row">
        <div class="col-md-3 col-6">
            <div class="card book-card h-100">
                <img src="images/Delia.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h6 class="card-title">Where the Crawdads Sing</h6>
                    <p class="card-text text-muted small">Delia Owens</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-warning text-dark">Fiction</span>
                        <h6 class="text-primary mb-0">$10.99</h6>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card book-card h-100">
                <img src="images/james.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h6 class="card-title">Atomic Habits</h6>
                    <p class="card-text text-muted small">James Clear</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-secondary">Self-Help</span>
                        <h6 class="text-primary mb-0">$11.99</h6>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card book-card h-100">
                <img src="images/matt.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h6 class="card-title">The Midnight Library</h6>
                    <p class="card-text text-muted small">Matt Haig</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-info">Fantasy</span>
                        <h6 class="text-primary mb-0">$13.99</h6>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-6">
            <div class="card book-card h-100">
                <img src="brit.png" class="card-img-top" alt="Book Cover">
                <div class="card-body">
                    <h6 class="card-title">The Vanishing Half</h6>
                    <p class="card-text text-muted small">Brit Bennett</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="badge bg-success">Literary</span>
                        <h6 class="text-primary mb-0">$12.99</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section class="bg-primary text-white py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h3>Subscribe to Our Newsletter</h3>
                <p>Get the latest updates on new releases, promotions, and literary events.</p>
            </div>
            <div class="col-md-6">
                <form class="row g-3">
                    <div class="col-8">
                        <input type="email" class="form-control" placeholder="Your email address">
                    </div>
                    <div class="col-4">
                        <button type="submit" class="btn btn-dark w-100">Subscribe</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5>Book Master</h5>
                <p>Your one-stop destination for all things literary. We pride ourselves on offering a carefully curated selection of books for every reader.</p>
            </div>
            <div class="col-md-2">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white">Home</a></li>
                    <li><a href="browse.jsp" class="text-white">Browse</a></li>

                </ul>
            </div>
            <div class="col-md-3">
                <h5>Customer Service</h5>
                <ul class="list-unstyled">
                    <li><a href="contact.jsp" class="text-white">Contact Us</a></li>
                    <li><a href="faq.jsp" class="text-white">FAQ</a></li>
                    <li><a href="shipping.jsp" class="text-white">Shipping Policy</a></li>
                    <li><a href="returns.jsp" class="text-white">Returns Policy</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Connect With Us</h5>
                <div class="social-links">
                    <a href="#" class="text-white me-2"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-2"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-2"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white me-2"><i class="fab fa-pinterest"></i></a>
                </div>
                <div class="mt-3">
                    <p><i class="fas fa-phone me-2"></i> (123) 456-7890</p>
                    <p><i class="fas fa-envelope me-2"></i> info@bookMaster.com</p>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-6">
                <p class="mb-0">&copy; 2023 Book Master. All rights reserved.</p>
            </div>

        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Simple cart counter update (would be replaced with actual backend integration)
    document.addEventListener('DOMContentLoaded', function() {
        // This would normally come from a session or database
        const cartCount = localStorage.getItem('cartCount') || 0;
        document.querySelector('.badge.bg-primary').textContent = cartCount;

        // Add to cart buttons functionality
        document.querySelectorAll('.btn-primary').forEach(button => {
            if (button.textContent.trim() === 'Add to Cart') {
                button.addEventListener('click', function() {
                    let currentCount = parseInt(localStorage.getItem('cartCount') || 0);
                    currentCount++;
                    localStorage.setItem('cartCount', currentCount);
                    document.querySelector('.badge.bg-primary').textContent = currentCount;

                    // Show toast notification
                    const toast = new bootstrap.Toast(document.getElementById('addedToCartToast'));
                    toast.show();
                });
            }
        });
    });
</script>

<!-- Toast Notification -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="addedToCartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header bg-primary text-white">
            <strong class="me-auto">Book Master8

            </strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            Item added to your cart successfully!
        </div>
    </div>
</div>
</body>
</html>