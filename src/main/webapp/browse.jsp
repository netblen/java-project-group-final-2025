<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Browse Books | Book Haven</title>
    <%@ include file="styles.jsp" %>
    <style>
        .filter-section {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 10px;
        }
        .book-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
        }
        .sort-section {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .sort-section input {
            padding: 5px 10px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="row">
        <!-- Sidebar Filters -->
        <div class="col-md-3">
            <div class="filter-section">
                <h5>Filters</h5>
                <strong>Genres</strong>
                <div>
                    <label><input type="checkbox" name="genre" value="All" checked> All Genres</label><br>
                    <label><input type="checkbox" name="genre" value="Classic"> Classic</label><br>
                    <label><input type="checkbox" name="genre" value="Science Fiction"> Science Fiction</label><br>
                    <label><input type="checkbox" name="genre" value="Fantasy"> Fantasy</label><br>
                    <label><input type="checkbox" name="genre" value="Horror"> Horror</label><br>
                </div>
                <hr>
                <strong>Price Range</strong>
                <input type="range" min="5" max="25" id="priceRange" value="25" class="form-range">
                <p>Max: $<span id="priceValue">25</span></p>
                <hr>
                <strong>Availability</strong>
                <div>
                    <label><input type="checkbox" name="availability" value="true" checked> In Stock</label><br>
                    <label><input type="checkbox" name="availability" value="false"> Out of Stock</label>
                </div>
                <hr>
                <button class="btn btn-primary w-100" onclick="applyFilters()">Apply Filters</button>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4 sort-section">
                <h4>All Books</h4>
                <input type="text" id="searchInput" placeholder="Search...">
                <select id="sortSelect" class="form-select w-auto">
                    <option value="default">Sort By</option>
                    <option value="price-low">Price: Low to High</option>
                    <option value="price-high">Price: High to Low</option>
                    <option value="title-asc">Title: A-Z</option>
                    <option value="title-desc">Title: Z-A</option>
                </select>
            </div>

            <div class="row" id="book-grid">
                <!-- JS injects book cards here -->
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    let books = [];

    document.addEventListener('DOMContentLoaded', function () {
        fetch('/java_project_group_final_2025_war_exploded/books')
            .then(response => response.json())
            .then(data => {
                books = data;
                renderBooks(books);
            });

        document.getElementById('priceRange').addEventListener('input', function () {
            document.getElementById('priceValue').innerText = this.value;
        });

        document.getElementById('sortSelect').addEventListener('change', applyFilters);
        document.getElementById('searchInput').addEventListener('input', applyFilters);
    });

    function applyFilters() {
        const selectedGenres = Array.from(document.querySelectorAll('input[name="genre"]:checked')).map(cb => cb.value);
        const selectedAvailability = Array.from(document.querySelectorAll('input[name="availability"]:checked')).map(cb => cb.value === "true");
        const maxPrice = parseFloat(document.getElementById('priceRange').value);
        const searchText = document.getElementById('searchInput').value.toLowerCase();
        const sort = document.getElementById('sortSelect').value;

        let filtered = books.filter(book => {
            const inGenre = selectedGenres.includes("All") || book.genres.some(g => selectedGenres.includes(g));
            const inStock = selectedAvailability.length === 0 || selectedAvailability.includes(book.available);
            const underPrice = book.bookPrice <= maxPrice;
            const matchesSearch = book.title.toLowerCase().includes(searchText);
            return inGenre && inStock && underPrice && matchesSearch;
        });

        if (sort === "price-low") {
            filtered.sort((a, b) => a.bookPrice - b.bookPrice);
        } else if (sort === "price-high") {
            filtered.sort((a, b) => b.bookPrice - a.bookPrice);
        } else if (sort === "title-asc") {
            filtered.sort((a, b) => a.title.localeCompare(b.title));
        } else if (sort === "title-desc") {
            filtered.sort((a, b) => b.title.localeCompare(a.title));
        }

        renderBooks(filtered);
    }

    function renderBooks(bookList) {
        const grid = document.getElementById('book-grid');
        grid.innerHTML = '';

        if (bookList.length === 0) {
            grid.innerHTML = "<p class='text-danger'>No books found matching filters.</p>";
            return;
        }

        bookList.forEach(book => {
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
    }

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
                const cart = JSON.parse(localStorage.getItem('bookCart') || '[]');
                const index = cart.findIndex(item => item.id == book.id);
                if (index >= 0) cart[index].quantity++;
                else cart.push(book);
                localStorage.setItem('bookCart', JSON.stringify(cart));
                updateCartCount();
            });
        });
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
</script>
</body>
</html>











