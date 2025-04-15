<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Book Master</title>
    <%@ include file="styles.jsp" %>
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
            color: white;
        }

        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
            margin-bottom: 5px;
        }

        .sidebar .nav-link:hover {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar .nav-link.active {
            color: white;
            background-color: var(--primary-color);
        }

        .sidebar .nav-link i {
            width: 20px;
            margin-right: 10px;
            text-align: center;
        }

        .stat-card {
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card .card-body {
            padding: 20px;
        }

        .stat-card .stat-icon {
            font-size: 2.5rem;
            opacity: 0.3;
            position: absolute;
            right: 20px;
            top: 20px;
        }

        .recent-orders {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block sidebar collapse bg-dark">
            <div class="position-sticky pt-3">
                <div class="text-center mb-4">
                    <h4>Book Master Admin</h4>
                    <hr>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="admin-dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-books.jsp">
                            <i class="fas fa-book"></i> Books
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-orders.jsp">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-customers.jsp">
                            <i class="fas fa-users"></i> Customers
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-genres.jsp">
                            <i class="fas fa-tags"></i> Genres
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-inventory.jsp">
                            <i class="fas fa-boxes"></i> Inventory
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-reports.jsp">
                            <i class="fas fa-chart-bar"></i> Reports
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-settings.jsp">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </li>
                </ul>

                <div class="position-absolute bottom-0 start-0 p-3 w-100">
                    <div class="d-flex align-items-center">
                        <img src="images/admin-avatar.jpg" alt="Admin" class="rounded-circle me-2" width="40">
                        <div>
                            <div class="fw-bold">Admin User</div>
                            <small class="text-muted">admin@bookmaster.com</small>
                        </div>
                    </div>
                    <a href="logout.jsp" class="btn btn-outline-light btn-sm w-100 mt-2">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Dashboard</h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                        <i class="fas fa-calendar"></i> This week
                    </button>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card stat-card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title">Total Sales</h5>
                            <h2 class="card-text">$12,345</h2>
                            <p class="card-text"><small>+12% from last month</small></p>
                            <i class="fas fa-dollar-sign stat-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title">New Orders</h5>
                            <h2 class="card-text">42</h2>
                            <p class="card-text"><small>+5 from yesterday</small></p>
                            <i class="fas fa-shopping-cart stat-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card bg-info text-white">
                        <div class="card-body">
                            <h5 class="card-title">Customers</h5>
                            <h2 class="card-text">1,234</h2>
                            <p class="card-text"><small>+32 this week</small></p>
                            <i class="fas fa-users stat-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card bg-warning text-dark">
                        <div class="card-body">
                            <h5 class="card-title">Low Stock</h5>
                            <h2 class="card-text">8</h2>
                            <p class="card-text"><small>Items need restocking</small></p>
                            <i class="fas fa-exclamation-triangle stat-icon"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts and Recent Orders -->
            <div class="row">
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5>Sales Overview</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="salesChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5>Top Genres</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="genresChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Recent Orders</h5>
                        </div>
                        <div class="card-body recent-orders">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>#BH10025</td>
                                        <td>John Smith</td>
                                        <td>2023-06-15</td>
                                        <td>$47.05</td>
                                        <td><span class="badge bg-success">Completed</span></td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>#BH10024</td>
                                        <td>Sarah Johnson</td>
                                        <td>2023-06-14</td>
                                        <td>$32.99</td>
                                        <td><span class="badge bg-warning text-dark">Processing</span></td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>#BH10023</td>
                                        <td>Michael Brown</td>
                                        <td>2023-06-14</td>
                                        <td>$56.78</td>
                                        <td><span class="badge bg-warning text-dark">Processing</span></td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>#BH10022</td>
                                        <td>Emily Davis</td>
                                        <td>2023-06-13</td>
                                        <td>$21.50</td>
                                        <td><span class="badge bg-info">Shipped</span></td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                    <tr>
                                        <td>#BH10021</td>
                                        <td>Robert Wilson</td>
                                        <td>2023-06-12</td>
                                        <td>$78.30</td>
                                        <td><span class="badge bg-success">Completed</span></td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">View</a></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="footer.jsp" %>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Sales Chart
    const salesCtx = document.getElementById('salesChart').getContext('2d');
    const salesChart = new Chart(salesCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Sales 2023',
                data: [1250, 1900, 1700, 2100, 2400, 2800],
                backgroundColor: 'rgba(74, 111, 165, 0.2)',
                borderColor: 'rgba(74, 111, 165, 1)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Genres Chart
    const genresCtx = document.getElementById('genresChart').getContext('2d');
    const genresChart = new Chart(genresCtx, {
        type: 'doughnut',
        data: {
            labels: ['Fiction', 'Mystery', 'Sci-Fi', 'Romance', 'Biography'],
            datasets: [{
                data: [35, 25, 20, 15, 5],
                backgroundColor: [
                    'rgba(74, 111, 165, 0.8)',
                    'rgba(54, 162, 235, 0.8)',
                    'rgba(255, 206, 86, 0.8)',
                    'rgba(75, 192, 192, 0.8)',
                    'rgba(153, 102, 255, 0.8)'
                ],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'right',
                }
            }
        }
    });
</script>
</body>
</html>