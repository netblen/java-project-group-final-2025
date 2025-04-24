<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart | Book Master</title>
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

        .book-cover {
            max-height: 120px;
            object-fit: cover;
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
                <span class="text-muted" id="cartItemCount">0 items</span>
            </div>

            <!-- Cart Items -->
            <div class="card mb-4" id="cartItemsContainer">
                <div class="card-body" id="cartItems">
                    <!-- Cart items will be loaded dynamically -->
                </div>
            </div>

            <!-- Empty Cart Message -->
            <div class="card mb-4 d-none" id="emptyCartMessage">
                <div class="card-body empty-cart">
                    <i class="fas fa-shopping-cart fa-4x text-muted mb-4"></i>
                    <h4 class="text-muted">Your cart is empty</h4>
                    <p class="text-muted mb-4">Looks like you haven't added any books to your cart yet.</p>
                    <a href="browse.jsp" class="btn btn-primary">
                        <i class="fas fa-book-open me-2"></i> Browse Books
                    </a>
                </div>
            </div>

            <div class="d-flex justify-content-between mb-4">
                <a href="browse.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </a>
                <button class="btn btn-outline-danger" id="clearCartBtn">
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
                        <span>Subtotal (<span id="summaryItemCount">0</span> items)</span>
                        <span id="subtotalAmount">$0.00</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Shipping</span>
                        <span class="text-success">FREE</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax (7%)</span>
                        <span id="taxAmount">$0.00</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <h5>Total</h5>
                        <h5 id="totalAmount">$0.00</h5>
                    </div>
                    <div class="d-grid">
                        <a href="checkout.jsp" class="btn btn-primary btn-lg" id="checkoutButton">Proceed to Checkout</a>
                    </div>
                    <div class="text-center mt-3">
                        <small class="text-muted">or</small>
                        <button class="btn btn-outline-primary w-100 mt-2">
                            <i class="fab fa-paypal"></i> Checkout with PayPal
                        </button>
                    </div>
                </div>
            </div>


            <!-- Secure Checkout -->
        </div>
    </div>
</div>


<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Load cart contents
        loadCart();

        // Set up event listeners
        document.getElementById('clearCartBtn').addEventListener('click', function() {
            clearCart();
        });

        document.getElementById('applyPromoBtn').addEventListener('click', function() {
            applyPromoCode();
        });

        // Set up cart item event delegation
        document.getElementById('cartItems').addEventListener('click', function(e) {
            // Delete button click
            if (e.target.classList.contains('fa-trash') || e.target.parentElement.classList.contains('fa-trash')) {
                const button = e.target.closest('button');
                const itemId = button.getAttribute('data-id');
                removeFromCart(itemId);
            }
        });

        // Set up quantity change event delegation
        document.getElementById('cartItems').addEventListener('change', function(e) {
            if (e.target.classList.contains('quantity-input')) {
                const itemId = e.target.getAttribute('data-id');
                const newQuantity = parseInt(e.target.value);
                if (newQuantity < 1) {
                    e.target.value = 1;
                    updateCartItemQuantity(itemId, 1);
                } else {
                    updateCartItemQuantity(itemId, newQuantity);
                }
            }
        });
    });

    // Load cart from localStorage and display items
    function loadCart() {
        const cart = JSON.parse(localStorage.getItem('bookCart')) || [];
        const cartItemsContainer = document.getElementById('cartItems');
        const emptyCartMessage = document.getElementById('emptyCartMessage');
        const cartItemsCard = document.getElementById('cartItemsContainer');

        // Update cart item count
        document.getElementById('cartItemCount').textContent = getTotalItems(cart) + ' items';

        if (cart.length === 0) {
            // Show empty cart message
            emptyCartMessage.classList.remove('d-none');
            cartItemsCard.classList.add('d-none');
            document.getElementById('clearCartBtn').disabled = true;
            document.getElementById('checkoutButton').disabled = true;
        } else {
            // Hide empty cart message and show items
            emptyCartMessage.classList.add('d-none');
            cartItemsCard.classList.remove('d-none');
            document.getElementById('clearCartBtn').disabled = false;
            document.getElementById('checkoutButton').disabled = false;

            // Generate HTML for cart items
            let cartHTML = '';
            cart.forEach(item => {
                cartHTML += `
                <div class="row align-items-center cart-item py-3 border-bottom" id="item-${item.id}">
                    <div class="col-md-2">
                        <img src="${item.img}" alt="${item.title}" class="img-fluid book-cover">
                    </div>
                    <div class="col-md-5">
                        <h5 class="mb-1">${item.title}</h5>
                        <p class="text-muted mb-1">${item.author}</p>
                        <span class="badge bg-${getBadgeColor(item.genre)}">${item.genre}</span>
                    </div>
                    <div class="col-md-2">
                        <input type="number" class="form-control quantity-input" value="${item.quantity}" min="1" data-id="${item.id}">
                    </div>
                    <div class="col-md-2 text-end">
                        <h5 class="mb-0">$${(item.price * item.quantity).toFixed(2)}</h5>
                    </div>
                    <div class="col-md-1 text-end">
                        <button class="btn btn-link text-danger" data-id="${item.id}"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                `;
            });

            cartItemsContainer.innerHTML = cartHTML;
        }

        // Update summary
        updateSummary(cart);
    }

    // Update cart summary calculations
    function updateSummary(cart) {