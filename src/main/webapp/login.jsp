<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Book Master</title>
    <%@ include file="styles.jsp" %>
    <style>
        .login-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: white;
        }

        .user-type-selector {
            margin-bottom: 20px;
        }

        .user-type-btn {
            width: 100%;
            text-align: center;
            padding: 10px;
            border: 2px solid #dee2e6;
            background: white;
            cursor: pointer;
            transition: all 0.3s;
        }

        .user-type-btn.active {
            border-color: #4a6fa5;
            background-color: rgba(74, 111, 165, 0.1);
        }

        .user-type-btn:first-child {
            border-radius: 5px 0 0 5px;
        }

        .user-type-btn:last-child {
            border-radius: 0 5px 5px 0;
        }

        input[type="radio"] {
            display: none;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="login-container">
        <h2 class="text-center mb-4">Welcome Back</h2>
        <p class="text-center text-muted mb-4">Sign in to access your account</p>

        <!-- Login Form -->
        <form action="login" method="POST">

            <!-- Email Field -->
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <!-- Password Field -->
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <!-- Remember Me Checkbox -->
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-100 mb-3">Sign In</button>

            <!-- Registration Link -->
            <div class="text-center">
                <p class="mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none">Sign up</a></p>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    // User type selection styling
    document.querySelectorAll('.user-type-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.user-type-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>
</body>
</html>