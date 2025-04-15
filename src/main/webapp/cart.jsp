<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart | Book Haven</title>
    <%@ include file="styles.jsp" %>
    <style>
        .cart-item {
            transition: all 0.3s;
        }

        .cart-item:hover {
            background-color: #f8f9fa;
        }

        .quantity-input {
            width: 60px;
            text-align: center;
        }

        .summary-card {
            position: sticky;
            top: 20px;
        }

        .empty-cart {
            min-height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Your Shopping Cart</h2>
                <span class="text-muted">3 items</span>
            </div>

            <!-- Cart Items -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row align-items-center cart-item py-3 border-bottom">
                        <div class="col-md-2">
                            <img src="images/cart1.jpg" alt="Book Cover" class="img-fluid">
                        </div>
                        <div class="col-md-5">
                            <h5 class="mb-1">The Silent Patient</h5>
                            <p class="text-muted mb-1">Alex Michaelides</p>
                            <span class="badge bg-primary">Thriller</span>
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control quantity-input" value="1" min="1">
                        </div>
                        <div class="col-md-2 text-end">
                            <h5 class="mb-0">$12.99</h5>
                        </div>
                        <div class="col-md-1 text-end">
                            <button class="btn btn-link text-danger"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>

                    <div class="row align-items-center cart-item py-3 border-bottom">
                        <div class="col-md-2">
                            <img src="images/cart2.jpg" alt="Book Cover" class="img-fluid">
                        </div>
                        <div class="col-md-5">
                            <h5 class="mb-1">Educated</h5>
                            <p class="text-muted mb-1">Tara Westover</p>
                            <span class="badge bg-success">Memoir</span>
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control quantity-input" value="1" min="1">
                        </div>
                        <div class="col-md-2 text-end">
                            <h5 class="mb-0">$14.99</h5>
                        </div>
                        <div class="col-md-1 text-end">
                            <button class="btn btn-link text-danger"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>

                    <div class="row align-items-center cart-item py-3">
                        <div class="col-md-2">
                            <img src="images/cart3.jpg" alt="Book Cover" class="img-fluid">
                        </div>
                        <div class="col-md-5">
                            <h5 class="mb-1">Project Hail Mary</h5>
                            <p class="text-muted mb-1">Andy Weir</p>
                            <span class="badge bg-info">Sci-Fi</span>
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control quantity-input" value="1" min="1">
                        </div>
                        <div class="col-md-2 text-end">
                            <h5 class="mb-0">$15.99</h5>
                        </div>
                        <div class="col-md-1 text-end">
                            <button class="btn btn-link text-danger"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between mb-4">
                <a href="browse.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </a>
                <button class="btn btn-outline-danger">
                    <i class="fas fa-trash"></i> Clear Cart
                </button>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="card summary-card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal (3 items)</span>
                        <span>$43.97</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Shipping</span>
                        <span class="text-success">FREE</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax</span>
                        <span>$3.08</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <h5>Total</h5>
                        <h5>$47.05</h5>
                    </div>
                    <div class="d-grid">
                        <a href="checkout.jsp" class="btn btn-primary btn-lg">Proceed to Checkout</a>
                    </div>
                    <div class="text-center mt-3">
                        <small class="text-muted">or</small>
                        <button class="btn btn-outline-primary w-100 mt-2">
                            <i class="fab fa-paypal"></i> Checkout with PayPal
                        </button>
                    </div>
                </div>
            </div>

            <!-- Promo Code -->
            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Promo Code</h5>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Enter promo code">
                        <button class="btn btn-outline-secondary" type="button">Apply</button>
                    </div>
                    <div class="alert alert-success d-none" id="promoSuccess">
                        Promo code applied successfully!
                    </div>
                    <div class="alert alert-danger d-none" id="promoError">
                        Invalid promo code
                    </div>
                </div>
            </div>

            <!-- Secure Checkout -->
            <div class="text-center mt-4">
                <p><i class="fas fa-lock me-2"></i>Secure Checkout</p>
                <div class="d-flex justify-content-center">
                    <img src="images/visa.png" alt="Visa" class="me-2" style="height: 30px;">
                    <img src="images/mastercard.png" alt="Mastercard" class="me-2" style="height: 30px;">
                    <img src="images/amex.png" alt="American Express" style="height: 30px;">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Recently Viewed -->
<section class="bg-light py-5">
    <div class="container">
        <h3 class="mb-4">Recently Viewed</h3>
        <div class="row">
            <div class="col-md-3 col-6">
                <div class="card book-card h-100">
                    <img src="images/recent1.jpg" class="card-img-top" alt="Book Cover">
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
                    <img src="images/recent2.jpg" class="card-img-top" alt="Book Cover">
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
                    <img src="images/recent3.jpg" class="card-img-top" alt="Book Cover">
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
                    <img src="images/recent4.jpg" class="card-img-top" alt="Book Cover">
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
    </div>
</section>

<%@ include file="footer.jsp" %>

<script>
    // Promo code functionality
    document.querySelector('.btn-outline-secondary').addEventListener('click', function() {
        const promoCode = document.querySelector('input[placeholder="Enter promo code"]').value;
        if (promoCode.toLowerCase() === 'bookhaven10') {
            document.getElementById('promoSuccess').classList.remove('d-none');
            document.getElementById('promoError').classList.add('d-none');

            // Here you would update the total with the discount
            // For demonstration, we'll just show the success message
        } else {
            document.getElementById('promoError').classList.remove('d-none');
            document.getElementById('promoSuccess').classList.add('d-none');
        }
    });

    // Quantity change handlers
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() {
            // Here you would update the cart total when quantity changes
            // For now, we'll just log the change
            console.log(`Quantity changed to ${this.value}`);
        });
    });
</script>
</body>
</html>