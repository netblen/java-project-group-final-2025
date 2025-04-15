<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books | Book Haven</title>
    <%@ include file="styles.jsp" %>
    <style>
        .filter-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 30px;
        }

        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .pagination .page-link {
            color: var(--primary-color);
        }

        .sort-dropdown .dropdown-toggle::after {
            display: none;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="row">
        <div class="col-md-3">
            <!-- Filters Section -->
            <div class="filter-section sticky-top" style="top: 20px;">
                <h5 class="mb-4">Filters</h5>

                <!-- Genre Filter -->
                <div class="mb-4">
                    <h6>Genres</h6>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-all" checked>
                        <label class="form-check-label" for="genre-all">All Genres</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-fiction">
                        <label class="form-check-label" for="genre-fiction">Fiction</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-mystery">
                        <label class="form-check-label" for="genre-mystery">Mystery</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-scifi">
                        <label class="form-check-label" for="genre-scifi">Science Fiction</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-fantasy">
                        <label class="form-check-label" for="genre-fantasy">Fantasy</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="genre-romance">
                        <label class="form-check-label" for="genre-romance">Romance</label>
                    </div>
                </div>

                <!-- Price Range -->
                <div class="mb-4">
                    <h6>Price Range</h6>
                    <div class="d-flex justify-content-between mb-2">
                        <span>$0</span>
                        <span>$50+</span>
                    </div>
                    <input type="range" class="form-range" min="0" max="50" step="5" id="priceRange">
                    <div class="d-flex justify-content-between">
                        <small class="text-muted">Min: $5</small>
                        <small class="text-muted">Max: $25</small>
                    </div>
                </div>

                <!-- Availability -->
                <div class="mb-4">
                    <h6>Availability</h6>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="availability-instock" checked>
                        <label class="form-check-label" for="availability-instock">In Stock</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="availability-outofstock">
                        <label class="form-check-label" for="availability-outofstock">Out of Stock</label>
                    </div>
                </div>

                <button class="btn btn-primary w-100">Apply Filters</button>
            </div>
        </div>

        <div class="col-md-9">
            <!-- Sort and Search -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4>All Books</h4>
                <div class="d-flex">
                    <div class="input-group me-3" style="width: 250px;">
                        <input type="text" class="form-control" placeholder="Search within results...">
                        <button class="btn btn-outline-secondary" type="button"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="dropdown sort-dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown">
                            <i class="fas fa-sort"></i> Sort By: Featured
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                            <li><a class="dropdown-item" href="#">Featured</a></li>
                            <li><a class="dropdown-item" href="#">Price: Low to High</a></li>
                            <li><a class="dropdown-item" href="#">Price: High to Low</a></li>
                            <li><a class="dropdown-item" href="#">Newest Arrivals</a></li>
                            <li><a class="dropdown-item" href="#">Customer Reviews</a></li>
                            <li><a class="dropdown-item" href="#">Bestsellers</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Book Grid -->
            <div class="row">
                <!-- This would be dynamically generated from the database -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card book-card h-100">
                        <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Bestseller</div>
                        <img src="images/book-grid1.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body">
                            <h5 class="card-title">The Invisible Life of Addie LaRue</h5>
                            <p class="card-text text-muted">V.E. Schwab</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-primary">Fantasy</span>
                                <h5 class="text-primary mb-0">$14.99</h5>
                            </div>
                            <div class="mt-3 d-grid gap-2">
                                <button class="btn btn-outline-primary">View Details</button>
                                <button class="btn btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card book-card h-100">
                        <img src="images/book-grid2.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body">
                            <h5 class="card-title">Klara and the Sun</h5>
                            <p class="card-text text-muted">Kazuo Ishiguro</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-info">Sci-Fi</span>
                                <h5 class="text-primary mb-0">$13.99</h5>
                            </div>
                            <div class="mt-3 d-grid gap-2">
                                <button class="btn btn-outline-primary">View Details</button>
                                <button class="btn btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card book-card h-100">
                        <img src="images/book-grid3.jpg" class="card-img-top" alt="Book Cover">
                        <div class="card-body">
                            <h5 class="card-title">The Four Winds</h5>
                            <p class="card-text text-muted">Kristin Hannah</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-success">Historical</span>
                                <h5 class="text-primary mb-0">$12.99</h5>
                            </div>
                            <div class="mt-3 d-grid gap-2">
                                <button class="btn btn-outline-primary">View Details</button>
                                <button class="btn btn-primary">Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- More book items would go here -->
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>