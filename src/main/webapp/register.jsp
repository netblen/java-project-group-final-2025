<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up | Book Master</title>
  <%@ include file="styles.jsp" %>
  <style>
    .register-container {
      max-width: 600px;
      margin: 0 auto;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      background-color: white;
    }

    .form-password-toggle {
      cursor: pointer;
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
    }

    .password-input-group {
      position: relative;
    }

    .thank-you-modal .modal-content {
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .thank-you-modal .modal-header {
      border-bottom: none;
      padding-bottom: 0;
    }

    .thank-you-modal .modal-body {
      padding: 20px 30px;
    }

    .thank-you-modal .btn-outline-primary:hover {
      background-color: #f8f9fa;
    }
  </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
  <div class="register-container">
    <h2 class="text-center mb-4">Create Your Account</h2>
    <p class="text-center text-muted mb-4">Join Book Haven to start your literary journey today!</p>

    <!-- Registration Form (will submit to RegisterServlet) -->
    <form action="customers" method="POST" id="registrationForm" onsubmit="return validateAndSubmit(event)">
    <div class="row mb-3">
        <div class="col-md-6 mb-3 mb-md-0">
          <label for="firstName" class="form-label">First Name*</label>
          <input type="text" class="form-control" id="firstName" name="firstName" required>
        </div>
        <div class="col-md-6">
          <label for="lastName" class="form-label">Last Name*</label>
          <input type="text" class="form-control" id="lastName" name="lastName" required>
        </div>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email Address*</label>
        <input type="email" class="form-control" id="email" name="email" required>
        <small class="text-muted">We'll never share your email.</small>
      </div>

      <div class="mb-3 password-input-group">
        <label for="password" class="form-label">Password*</label>
        <input type="password" class="form-control" id="password" name="password" required>
        <span class="form-password-toggle" onclick="togglePassword()">
          <i class="fas fa-eye"></i>
        </span>
        <div class="form-text">Must be at least 8 characters.</div>
      </div>

      <div class="mb-3 password-input-group">
        <label for="confirmPassword" class="form-label">Confirm Password*</label>
        <input type="password" class="form-control" id="confirmPassword" required>
        <span class="form-password-toggle" onclick="toggleConfirmPassword()">
          <i class="fas fa-eye"></i>
        </span>
      </div>

      <!-- Hidden userType field (default: 'customer') -->
      <input type="hidden" name="userType" value="customer">

      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="termsAgree" required>
        <label class="form-check-label" for="termsAgree">
          I agree to the <a href="terms.jsp">Terms & Conditions</a> and <a href="privacy.jsp">Privacy Policy</a>*
        </label>
      </div>

      <button type="submit" class="btn btn-primary w-100 mb-3">Create Account</button>

      <div class="text-center">
        <p class="mb-0">Already have an account? <a href="login.jsp" class="text-decoration-none">Sign In</a></p>
      </div>
    </form>
  </div>
</div>

<!-- Thank You Modal -->
<div class="modal fade thank-you-modal" id="thankYouModal" tabindex="-1" aria-labelledby="thankYouModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h5 class="modal-title w-100" id="thankYouModalLabel">
          <i class="fas fa-check-circle text-success me-2"></i>Registration Successful!
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <h4 class="mb-3">Thank you for joining Book Haven!</h4>
        <p class="mb-4">We're excited to have you as part of our reading community. Where would you like to go next?</p>
        <div class="d-flex justify-content-center gap-3">
          <a href="index.jsp" class="btn btn-outline-primary px-4">
            <i class="fas fa-home me-2"></i>Go Home
          </a>
          <a href="login.jsp" class="btn btn-primary px-4">
            <i class="fas fa-sign-in-alt me-2"></i>Sign In
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script>
  // Toggle password visibility
  function togglePassword() {
    const passwordInput = document.getElementById('password');
    const icon = document.querySelector('#password + .form-password-toggle i');

    if (passwordInput.type === 'password') {
      passwordInput.type = 'text';
      icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
      passwordInput.type = 'password';
      icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
  }

  // Toggle confirm password visibility
  function toggleConfirmPassword() {
    const confirmInput = document.getElementById('confirmPassword');
    const icon = document.querySelector('#confirmPassword + .form-password-toggle i');

    if (confirmInput.type === 'password') {
      confirmInput.type = 'text';
      icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
      confirmInput.type = 'password';
      icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
  }

  // Form validation and submission handling
  // function validateAndSubmit(event) {
  //   const password = document.getElementById('password').value;
  //   const confirmPassword = document.getElementById('confirmPassword').value;
  //
  //   if (password !== confirmPassword) {
  //     alert('Passwords do not match!');
  //     return false;
  //   }
  //
  //   if (password.length < 8) {
  //     alert('Password must be at least 8 characters!');
  //     return false;
  //   }
  //
  //   // For normal form submission without AJAX, we would show the modal after page reload
  //   // using a session attribute or request parameter set by the server
  //
  //   // This is a simplistic approach for demonstration purposes
  //   // In production, you'd validate on the server and only show this on success
  //
  //   // Prevent the default form submission
  //   event.preventDefault();
  //
  //   // Simulate form submission (in real app, submit via AJAX or redirect after server processing)
  //   setTimeout(() => {
  //     // Show the modal after "submission"
  //     const thankYouModal = new bootstrap.Modal(document.getElementById('thankYouModal'));
  //     thankYouModal.show();
  //
  //     // In a real implementation with AJAX:
  //     // Submit the form data to the server
  //     // On success response, show the modal
  //     // On error, show appropriate message
  //   }, 500);
  //
  //   return false; // Prevent default form submission
  // }

  function validateAndSubmit(event) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
      alert('Passwords do not match!');
      event.preventDefault();
      return false;
    }

    if (password.length < 8) {
      alert('Password must be at least 8 characters!');
      event.preventDefault();
      return false;
    }

    return true;
  }


  // In a real implementation with normal form submission and server processing:
  // Check if there's a success parameter in the URL when page loads
  document.addEventListener('DOMContentLoaded', function() {
    // This is where you'd check for a success parameter if implementing server-side redirect
    // For example: if(window.location.search.includes('registration=success'))
  });
</script>
</body>
</html>