<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Silent Patient | Book Haven</title>
    <%@ include file="styles.jsp" %>
    <style>
        .book-detail-img {
            max-height: 500px;
            width: auto;
            object-fit: contain;
        }

        .author-link:hover {
            text-decoration: underline !important;
        }

        .rating-stars {
            color: #ffc107;
        }

        .quantity-selector {
            width: 80px;
            text-align: center;
        }

        .tab-content {
            padding: 20px;
            border-left: 1px solid #dee2e6;
            border-right: 1px solid #dee2e6;
            border-bottom: 1px solid #dee2e6;
            border-radius: 0 0 8px 8px;
        }

        .nav-tabs .nav-link.active {
            background-color: white;
            border-bottom-color: white;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="browse.jsp">Books</a></li>
            <li class="breadcrumb-item"><a href="genres.jsp?genre=thriller">Thriller</a></li>
            <li class="breadcrumb-item active" aria-current="page">The Silent Patient</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Book Image -->
        <div class="col-md-5">
            <div class="card mb-4">
                <img src="images/book-detail.jpg" class="card-img-top book-detail-img" alt="The Silent Patient">
            </div>
            <div class="text-center">
                <button class="btn btn-outline-secondary me-2">
                    <i class="fas fa-heart"></i> Add to Wishlist
                </button>
                <button class="btn btn-outline-secondary">
                    <i class="fas fa-share-alt"></i> Share
                </button>
            </div>
        </div>

        <!-- Book Details -->
        <div class="col-md-7">
            <h1>The Silent Patient</h1>
            <p class="text-muted">by <a href="author.jsp?id=123" class="text-muted author-link">Alex Michaelides</a></p>

            <div class="d-flex align-items-center mb-3">
                <div class="rating-stars me-2">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
                <span class="text-muted me-3">4.5 (1,234 reviews)</span>
                <span class="badge bg-success">In Stock</span>
            </div>

            <div class="mb-4">
                <h3 class="text-primary">$12.99</h3>
                <p class="text-success"><i class="fas fa-check-circle"></i> Eligible for FREE Shipping</p>
            </div>

            <div class="mb-4">
                <h5>About this book</h5>
                <p>Alicia Berenson's life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of London's most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.</p>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <p><strong>Publisher:</strong> Celadon Books</p>
                    <p><strong>ISBN-10:</strong> 1250301696</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Publication Date:</strong> February 5, 2019</p>
                    <p><strong>Pages:</strong> 336</p>
                </div>
            </div>

            <!-- Add to Cart Section -->
            <div class="card bg-light p-4 mb-4">
                <div class="d-flex align-items-center mb-3">
                    <label class="me-2">Quantity:</label>
                    <select class="form-select quantity-selector">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                    </select>
                </div>
                <div class="d-grid gap-3">
                    <button class="btn btn-primary btn-lg">
                        <i class="fas fa-shopping-cart"></i> Add to Cart
                    </button>
                    <button class="btn btn-outline-primary btn-lg">
                        Buy Now
                    </button>
                </div>
            </div>

            <!-- Delivery Options -->
            <div class="mb-4">
                <h5><i class="fas fa-truck me-2"></i>Delivery Options</h5>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="deliveryOption" id="standardDelivery" checked>
                    <label class="form-check-label" for="standardDelivery">
                        <strong>Standard Delivery</strong> - FREE<br>
                        <small>Estimated delivery 3-5 business days</small>
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="deliveryOption" id="expressDelivery">
                    <label class="form-check-label" for="expressDelivery">
                        <strong>Express Delivery</strong> - $5.99<br>
                        <small>Estimated delivery 1-2 business days</small>
                    </label>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs mt-5" id="bookTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button">Description</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="details-tab" data-bs-toggle="tab" data-bs-target="#details" type="button">Product Details</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button">Reviews</button>
        </li>
    </ul>
    <div class="tab-content" id="bookTabsContent">
        <div class="tab-pane fade show active" id="description" role="tabpanel">
            <h4>Full Description</h4>
            <p>Alicia Berenson's life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of London's most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.</p>
            <p>Alicia's refusal to talk, or give any kind of explanation, turns a domestic tragedy into something far grander, a mystery that captures the public imagination and casts Alicia into notoriety. The price of her art skyrockets, and she, the silent patient, is hidden away from the tabloids and spotlight at the Grove, a secure forensic unit in North London.</p>
            <p>Theo Faber is a criminal psychotherapist who has waited a long time for the opportunity to work with Alicia. His determination to get her to talk and unravel the mystery of why she shot her husband takes him down a twisting path into his own motivations—a search for the truth that threatens to consume him....</p>
        </div>
        <div class="tab-pane fade" id="details" role="tabpanel">
            <h4>Product Details</h4>
            <table class="table">
                <tr>
                    <th>Publisher</th>
                    <td>Celadon Books (February 5, 2019)</td>
                </tr>
                <tr>
                    <th>Language</th>
                    <td>English</td>
                </tr>
                <tr>
                    <th>Hardcover</th>
                    <td>336 pages</td>
                </tr>
                <tr>
                    <th>ISBN-10</th>
                    <td>1250301696</td>
                </tr>
                <tr>
                    <th>ISBN-13</th>
                    <td>978-1250301697</td>
                </tr>
                <tr>
                    <th>Item Weight</th>
                    <td>1.2 pounds</td>
                </tr>
                <tr>
                    <th>Dimensions</th>
                    <td>6.4 x 1.2 x 9.5 inches</td>
                </tr>
            </table>
        </div>
        <div class="tab-pane fade" id="reviews" role="tabpanel">
            <h4>Customer Reviews</h4>
            <div class="row mb-4">
                <div class="col-md-4 text-center">
                    <h1 class="display-4">4.5</h1>
                    <div class="rating-stars mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p class="text-muted">1,234 global ratings</p>
                </div>
                <div class="col-md-8">
                    <div class="mb-2">
                        <span class="me-2">5 star</span>
                        <div class="progress" style="height: 10px; width: 80%">
                            <div class="progress-bar bg-success" style="width: 65%"></div>
                        </div>
                        <span class="ms-2">65%</span>
                    </div>
                    <div class="mb-2">
                        <span class="me-2">4 star</span>
                        <div class="progress" style="height: 10px; width: 80%">
                            <div class="progress-bar bg-success" style="width: 20%"></div>
                        </div>
                        <span class="ms-2">20%</span>
                    </div>
                    <div class="mb-2">
                        <span class="me-2">3 star</span>
                        <div class="progress" style="height: 10px; width: 80%">
                            <div class="progress-bar bg-warning" style="width: 8%"></div>
                        </div>
                        <span class="ms-2">8%</span>
                    </div>
                    <div class="mb-2">
                        <span class="me-2">2 star</span>
                        <div class="progress" style="height: 10px; width: 80%">
                            <div class="progress-bar bg-danger" style="width: 4%"></div>
                        </div>
                        <span class="ms-2">4%</span>
                    </div>
                    <div class="mb-2">
                        <span class="me-2">1 star</span>
                        <div class="progress" style="height: 10px; width: 80%">
                            <div class="progress-bar bg-danger" style="width: 3%"></div>
                        </div>
                        <span class="ms-2">3%</span>
                    </div>
                </div>
            </div>

            <div class="mb-4">
                <h5>Write a Review</h5>
                <form>
                    <div class="mb-3">
                        <label class="form-label">Rating</label>
                        <div class="rating-input">
                            <i class="far fa-star" data-rating="1"></i>
                            <i class="far fa-star" data-rating="2"></i>
                            <i class="far fa-star" data-rating="3"></i>
                            <i class="far fa-star" data-rating="4"></i>
                            <i class="far fa-star" data-rating="5"></i>
                            <input type="hidden" name="rating" id="ratingValue">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="reviewTitle" class="form-label">Review Title</label>
                        <input type="text" class="form-control" id="reviewTitle">
                    </div>
                    <div class="mb-3">
                        <label for="reviewText" class="form-label">Your Review</label>
                        <textarea class="form-control" id="reviewText" rows="3"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Review</button>
                </form>
            </div>

            <!-- Sample Reviews -->
            <div class="review">
                <div class="d-flex justify-content-between">
                    <h5>Couldn't put it down!</h5>
                    <div class="rating-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <p class="text-muted">Reviewed by Jane D. on March 15, 2023</p>
                <p>This book had me hooked from the first page. The psychological depth and unexpected twists kept me reading late into the night. The ending was completely unexpected but made perfect sense in hindsight. Highly recommend!</p>
            </div>

            <div class="review mt-4">
                <div class="d-flex justify-content-between">
                    <h5>Masterful psychological thriller</h5>
                    <div class="rating-stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
                <p class="text-muted">Reviewed by BookLover42 on February 28, 2023</p>
                <p>Alex Michaelides crafts a taut, suspenseful narrative that explores the complexities of the human psyche. The characters are well-developed and the pacing is perfect. My only minor complaint is that some plot elements felt slightly rushed toward the end, but it's still one of the best thrillers I've read this year.</p>
            </div>
        </div>
    </div>
</div>

<!-- Similar Books Section -->
<section class="bg-light py-5">
    <div class="container">
        <h3 class="mb-4">You May Also Like</h3>
        <div class="row">
            <!-- Similar books would be dynamically generated -->
            <div class="col-md-3 col-6">
                <div class="card book-card h-100">
                    <img src="images/similar1.jpg" class="card-img-top" alt="Book Cover">
                    <div class="card-body">
                        <h6 class="card-title">The Girl on the Train</h6>
                        <p class="card-text text-muted small">Paula Hawkins</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="badge bg-primary">Thriller</span>
                            <h6 class="text-primary mb-0">$10.99</h6>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card book-card h-100">
                    <img src="images/similar2.jpg" class="card-img-top" alt="Book Cover">
                    <div class="card-body">
                        <h6 class="card-title">Gone Girl</h6>
                        <p class="card-text text-muted small">Gillian Flynn</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="badge bg-primary">Thriller</span>
                            <h6 class="text-primary mb-0">$11.99</h6>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card book-card h-100">
                    <img src="images/similar3.jpg" class="card-img-top" alt="Book Cover">
                    <div class="card-body">
                        <h6 class="card-title">The Woman in the Window</h6>
                        <p class="card-text text-muted small">A.J. Finn</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="badge bg-primary">Thriller</span>
                            <h6 class="text-primary mb-0">$12.99</h6>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="card book-card h-100">
                    <img src="images/similar4.jpg" class="card-img-top" alt="Book Cover">
                    <div class="card-body">
                        <h6 class="card-title">Sharp Objects</h6>
                        <p class="card-text text-muted small">Gillian Flynn</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="badge bg-primary">Thriller</span>
                            <h6 class="text-primary mb-0">$9.99</h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

<script>
    // Rating stars interaction
    document.querySelectorAll('.rating-input i').forEach(star => {
        star.addEventListener('click', function() {
            const rating = this.getAttribute('data-rating');
            document.getElementById('ratingValue').value = rating;

            // Update star display
            document.querySelectorAll('.rating-input i').forEach((s, index) => {
                if (index < rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                } else {
                    s.classList.remove('fas');
                    s.classList.add('far');
                }
            });
        });
    });
</script>
</body>
</html>