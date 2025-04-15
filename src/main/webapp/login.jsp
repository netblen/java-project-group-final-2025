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

        .social-login .btn {
            width: 100%;
            margin-bottom: 10px;
            position: relative;
            text-align: center;
        }

        .social-login .btn i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 20px 0;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }

        .divider::before {
            margin-right: 10px;
        }

        .divider::after {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container py-5">
    <div class="login-container">
        <h2 class="text-center mb-4">Welcome Back</h2>
        <p class="text-center text-muted mb-4">Sign in to access your account and continue your literary journey.</p>

        <!-- Social Login -->
        <div class="social-login mb-4">
            <button class="btn btn-outline-primary">
                <i class="fab fa-google"></i> Continue with Google
            </button>
            <button class="btn btn-outline-dark">
                <i class="fab fa-facebook-f"></i> Continue with Facebook
            </button>
        </div>

        <div class="divider">OR</div>

        <!-- Email Login Form -->
        <form action="LoginServlet" method="POST">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
                <div class="text-end mt-2">
                    <a href="forgot-password.jsp" class="text-decoration-none">Forgot password?</a>
                </div>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">Sign In</button>

            <div class="text-center">
                <p class="mb-0">Don't have an account? <a href="register.jsp" class="text-decoration-none">Sign up</a></p>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>