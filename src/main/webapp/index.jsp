<<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Master - Your Literary Book Bestie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Georgia', serif;
            background-color: #f9f5f0;
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.8rem;
        }
        .hero-section {
            background: #555;
            color: white;
            padding: 5rem 0;
            margin-bottom: 3rem;
        }
        .book-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<%@ include file="navbar.jsp" %>

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

<!-- Featured Books Section -->
<section class="container mb-5">
    <h2 class="text-center mb-4">Featured Books</h2>
    <div class="row" id="featured-books">
        <!-- JS-injected content -->
    </div>
    <div class="text-center mt-4">
        <a href="browse.jsp" class="btn btn-outline-dark btn-lg">View All Books</a>
    </div>
</section>

<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        fetch('/java_project_group_final_2025_war_exploded/books')
            .then(response => response.json())
            .then(books => {
                const grid = document.getElementById('featured-books');
                grid.innerHTML = '';

                books.slice(0, 3).forEach(book => {
                    const genre = book.genres.length > 0 ? book.genres[0] : 'N/A';
                    const badgeClass = genre.toLowerCase().includes('sci') ? 'bg-info'
                        : genre.toLowerCase().includes('fantasy') ? 'bg-primary'
                            : genre.toLowerCase().includes('classic') ? 'bg-warning'
                                : 'bg-secondary';

                    const card = `
                          <div class="col-lg-4 col-md-6 mb-4">
                              <div class="card book-card h-100">
                                  <div class="card-body">
                                      <h5 class="card-title">\${book.title}</h5>
                                      <p class="card-text text-muted">\${book.author}</p>
                                      <div class="d-flex justify-content-between align-items-center">
                                          <span class="badge \${badgeClass}">\${genre}</span>
                                          <h5 class="text-primary mb-0">$\${book.bookPrice}</h5>
                                      </div>
                                      <div class="mt-3 d-grid gap-2">
                                          <button class="btn btn-outline-primary">View Details</button>
                                          <button class="btn btn-primary add-to-cart-btn"
                                                  data-id="\${book.bookId}"
                                                  data-title="\${book.title}"
                                                  data-author="\${book.author}"
                                                  data-genre="\${genre}"
                                                  data-price="\${book.bookPrice}">
                                              Add to Cart
                                          </button>
                                      </div>
                                  </div>
                              </div>
                          </div>`;
                    grid.insertAdjacentHTML('beforeend', card);
                });

                attachCartListeners();
                updateCartCount();
            })
            .catch(error => {
                console.error("Error loading books:", error);
                document.getElementById('featured-books').innerHTML = "<p class='text-danger'>Failed to load books.</p>";
            });

        function attachCartListeners() {
            document.querySelectorAll('.add-to-cart-btn').forEach(button => {
                button.addEventListener('click', function () {
                    const book = {
                        id: this.dataset.id,
                        title: this.dataset.title,
                        author: this.dataset.author,
                        genre: this.dataset.genre,
                        price: parseFloat(this.dataset.price),
                        quantity: 1
                    };
                    addToCart(book);
                    showNotification(`"${book.title}" added to your cart!`);
                });
            });
        }

        function addToCart(book) {
            const cart = JSON.parse(localStorage.getItem('bookCart') || '[]');
            const index = cart.findIndex(item => item.id == book.id);
            if (index >= 0) {
                cart[index].quantity += 1;
            } else {
                cart.push(book);
            }
            localStorage.setItem('bookCart', JSON.stringify(cart));
            updateCartCount();
        }

        function updateCartCount() {
            const cart = JSON.parse(localStorage.getItem('bookCart') || '[]');
            const count = cart.reduce((sum, item) => sum + item.quantity, 0);
            const counter = document.querySelector('.cart-counter');
            if (counter) {
                counter.textContent = count;
                counter.classList.toggle('d-none', count === 0);
            }
        }

        function showNotification(message) {
            const toast = document.getElementById('addedToCartToast');
            const messageElement = document.getElementById('cartNotificationMessage');
            if (toast && messageElement) {
                messageElement.textContent = message;
                new bootstrap.Toast(toast).show();
            }
        }
    });
</script>
</body>
</html>
