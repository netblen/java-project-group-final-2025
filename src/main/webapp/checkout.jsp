<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Book Master</title>
    <%@ include file="styles.jsp" %>
    <style>
        .checkout-step {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            font-weight: bold;
        }

        .step-number.active {
            background-color: var(--primary-color);
            color: white;
        }

        .step-label {
            font-weight: 500;
            color: #6c757d;
        }

        .step-label.active {
            color: var(--primary-color);
            font-weight: bold;
        }

        .checkout-section {
            display: none;
        }

        .checkout-section.active {
            display: block;
        }

        .saved-address {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .saved-address:hover {
            border-color: var(--primary-color);
            background-color: rgba(74, 111, 165, 0.05);
        }

        .saved-address.selected {
            border-color: var(--primary-color);
            background-color: rgba(74, 111, 165, 0.1);
        }

        .payment-method {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
        }

        .payment-method:hover {
            border-color: var(--primary-color);
        }

        .payment-method.selected {
            border-color: var(--primary-color);
            background-color: rgba(74, 111, 165, 0.1);
        }

        .order-summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-8">
            <!-- Checkout Progress -->
            <div class="d-flex justify-content-between mb-5">
                <div class="checkout-step">
                    <div class="step-number active">1</div>
                    <div class="step-label active">Shipping</div>
                </div>
                <div class="flex-grow-1 border-top mt-3 mx-2" style="border-color: var(--primary-color)"></div>
                <div class="checkout-step">
                    <div class="step-number">2</div>
                    <div class="step-label">Payment</div>
                </div>
                <div class="flex-grow-1 border-top mt-3 mx-2"></div>
                <div class="checkout-step">
                    <div class="step-number">3</div>
                    <div class="step-label">Review</div>
                </div>
            </div>

            <!-- Shipping Section -->
            <div class="checkout-section active" id="shippingSection">
                <h3 class="mb-4">Shipping Information</h3>

                <div class="mb-4">
                    <h5>Saved Addresses</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="saved-address selected">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="address" id="address1" checked>
                                    <label class="form-check-label" for="address1">
                                        <strong>Home</strong>
                                    </label>
                                </div>
                                <p class="mb-1">John Doe</p>
                                <p class="mb-1">123 Main Street</p>
                                <p class="mb-1">Apt 4B</p>
                                <p class="mb-1">New York, NY 10001</p>
                                <p class="mb-1">United States</p>
                                <p class="mb-1">Phone: (123) 456-7890</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="saved-address">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="address" id="address2">
                                    <label class="form-check-label" for="address2">
                                        <strong>Work</strong>
                                    </label>
                                </div>
                                <p class="mb-1">John Doe</p>
                                <p class="mb-1">456 Business Ave</p>
                                <p class="mb-1">Floor 10</p>
                                <p class="mb-1">New York, NY 10005</p>
                                <p class="mb-1">United States</p>
                                <p class="mb-1">Phone: (123) 456-7891</p>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-outline-primary mt-2">
                        <i class="fas fa-plus"></i> Add New Address
                    </button>
                </div>

                <div class="mb-4">
                    <h5>Shipping Method</h5>
                    <div class="card">
                        <div class="card-body">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="shippingMethod" id="standardShipping" checked>
                                <label class="form-check-label" for="standardShipping">
                                    <strong>Standard Shipping</strong> - FREE<br>
                                    <small>Estimated delivery 3-5 business days</small>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="shippingMethod" id="expressShipping">
                                <label class="form-check-label" for="expressShipping">
                                    <strong>Express Shipping</strong> - $5.99<br>
                                    <small>Estimated delivery 1-2 business days</small>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="cart.jsp" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Cart
                    </a>
                    <button class="btn btn-primary" onclick="nextStep('paymentSection')">
                        Continue to Payment <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <!-- Payment Section -->
            <div class="checkout-section" id="paymentSection">
                <h3 class="mb-4">Payment Method</h3>

                <div class="mb-4">
                    <div class="payment-method selected">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" checked>
                            <label class="form-check-label" for="creditCard">
                                <strong>Credit/Debit Card</strong>
                            </label>
                        </div>
                        <div class="mt-3" id="creditCardForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="cardNumber" class="form-label">Card Number</label>
                                    <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                                </div>
                                <div class="col-md-3">
                                    <label for="expiryDate" class="form-label">Expiry Date</label>
                                    <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
                                </div>
                                <div class="col-md-3">
                                    <label for="cvv" class="form-label">CVV</label>
                                    <input type="text" class="form-control" id="cvv" placeholder="123">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <label for="cardName" class="form-label">Name on Card</label>
                                    <input type="text" class="form-control" id="cardName" placeholder="John Doe">
                                </div>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="saveCard">
                                <label class="form-check-label" for="saveCard">Save this card for future purchases</label>
                            </div>
                        </div>
                    </div>

                    <div class="payment-method">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="paypal">
                            <label class="form-check-label" for="paypal">
                                <strong>PayPal</strong>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <button class="btn btn-outline-secondary" onclick="prevStep('shippingSection')">
                        <i class="fas fa-arrow-left"></i> Back to Shipping
                    </button>
                    <button class="btn btn-primary" onclick="nextStep('reviewSection')">
                        Review Order <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <!-- Review Section -->
            <div class="checkout-section" id="reviewSection">
                <h3 class="mb-4">Review Your Order</h3>

                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">Shipping Information</h5>
                    </div>
                    <div class="card-body">
                        <p class="mb-1"><strong>John Doe</strong></p>
                        <p class="mb-1">123 Main Street, Apt 4B</p>
                        <p class="mb-1">New York, NY 10001</p>
                        <p class="mb-1">United States</p>
                        <p class="mb-1">Phone: (123) 456-7890</p>
                        <p class="mb-0"><strong>Shipping Method:</strong> Standard Shipping (FREE)</p>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">Payment Method</h5>
                    </div>
                    <div class="card-body">
                        <p class="mb-1"><strong>Visa ending in 3456</strong></p>
                        <p class="mb-1">Expires 05/25</p>
                        <p class="mb-0">John Doe</p>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">Order Items</h5>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-center mb-3">
                            <div class="col-md-2">
                                <img src="images/cart1.jpg" alt="Book Cover" class="img-fluid">
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-1">The Silent Patient</h6>
                                <p class="text-muted small mb-1">Alex Michaelides</p>
                            </div>
                            <div class="col-md-2 text-center">
                                <span>1</span>
                            </div>
                            <div class="col-md-2 text-end">
                                <h6 class="mb-0">$12.99</h6>
                            </div>
                        </div>

                        <div class="row align-items-center mb-3">
                            <div class="col-md-2">
                                <img src="images/cart2.jpg" alt="Book Cover" class="img-fluid">
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-1">Educated</h6>
                                <p class="text-muted small mb-1">Tara Westover</p>
                            </div>
                            <div class="col-md-2 text-center">
                                <span>1</span>
                            </div>
                            <div class="col-md-2 text-end">
                                <h6 class="mb-0">$14.99</h6>
                            </div>
                        </div>

                        <div class="row align-items-center">
                            <div class="col-md-2">
                                <img src="images/cart3.jpg" alt="Book Cover" class="img-fluid">
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-1">Project Hail Mary</h6>
                                <p class="text-muted small mb-1">Andy Weir</p>
                            </div>
                            <div class="col-md-2 text-center">
                                <span>1</span>
                            </div>
                            <div class="col-md-2 text-end">
                                <h6 class="mb-0">$15.99</h6>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" id="termsAgree" required>
                    <label class="form-check-label" for="termsAgree">
                        I agree to the <a href="terms.jsp">Terms and Conditions</a> and <a href="privacy.jsp">Privacy Policy</a>
                    </label>
                </div>

                <div class="d-flex justify-content-between">
                    <button class="btn btn-outline-secondary" onclick="prevStep('paymentSection')">
                        <i class="fas fa-arrow-left"></i> Back to Payment
                    </button>
                    <button class="btn btn-success btn-lg" onclick="placeOrder()">
                        <i class="fas fa-check-circle"></i> Place Order
                    </button>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="card sticky-top" style="top: 20px;">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <div class="order-summary-item">
                        <span>Subtotal (3 items)</span>
                        <span>$43.97</span>
                    </div>
                    <div class="order-summary-item">
                        <span>Shipping</span>
                        <span class="text-success">FREE</span>
                    </div>
                    <div class="order-summary-item">
                        <span>Tax</span>
                        <span>$3.08</span>
                    </div>
                    <hr>
                    <div class="order-summary-item">
                        <h5>Total</h5>
                        <h5>$47.05</h5>
                    </div>
                </div>
            </div>



            <!-- Need Help? -->
            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Need Help?</h5>
                    <p class="card-text">Our customer service team is available 24/7 to assist you with your order.</p>
                    <p class="card-text"><i class="fas fa-phone me-2"></i>(800) 123-4567</p>
                    <p class="card-text"><i class="fas fa-envelope me-2"></i>support@bookMaster.com</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    // Checkout step navigation
    function nextStep(nextSectionId) {
        document.querySelectorAll('.checkout-section').forEach(section => {
            section.classList.remove('active');
        });
        document.getElementById(nextSectionId).classList.add('active');

        // Update progress indicators
        const currentStep = document.querySelector(`.checkout-section.active`);
        if (currentStep.id === 'paymentSection') {
            updateProgress(2);
        } else if (currentStep.id === 'reviewSection') {
            updateProgress(3);
        }
    }

    function prevStep(prevSectionId) {
        document.querySelectorAll('.checkout-section').forEach(section => {
            section.classList.remove('active');
        });
        document.getElementById(prevSectionId).classList.add('active');

        // Update progress indicators
        if (prevSectionId === 'shippingSection') {
            updateProgress(1);
        } else if (prevSectionId === 'paymentSection') {
            updateProgress(2);
        }
    }

    function updateProgress(step) {
        // Reset all steps
        document.querySelectorAll('.step-number').forEach((el, index) => {
            if (index + 1 <= step) {
                el.classList.add('active');
            } else {
                el.classList.remove('active');
            }
        });

        document.querySelectorAll('.step-label').forEach((el, index) => {
            if (index + 1 <= step) {
                el.classList.add('active');
            } else {
                el.classList.remove('active');
            }
        });

        // Update progress bar
        document.querySelectorAll('.flex-grow-1.border-top').forEach((el, index) => {
            if (index + 1 < step) {
                el.style.borderColor = 'var(--primary-color)';
            } else {
                el.style.borderColor = '#dee2e6';
            }
        });
    }

    // Payment method selection
    document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.id === 'creditCard') {
                document.getElementById('creditCardForm').style.display = 'block';
            } else {
                document.getElementById('creditCardForm').style.display = 'none';
            }
        });
    });

    // Address selection
    document.querySelectorAll('.saved-address').forEach(address => {
        address.addEventListener('click', function() {
            document.querySelectorAll('.saved-address').forEach(addr => {
                addr.classList.remove('selected');
            });
            this.classList.add('selected');
            this.querySelector('input[type="radio"]').checked = true;
        });
    });

    // Place order function
    function placeOrder() {
        if (document.getElementById('termsAgree').checked) {
            // In a real application, this would submit the form to the server
            // For demo, we'll redirect to order confirmation
            window.location.href = 'order-confirmation.jsp';
        } else {
            alert('Please agree to the terms and conditions before placing your order.');
        }
    }
</script>
</body>
</html>