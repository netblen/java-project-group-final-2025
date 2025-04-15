<style>
    :root {
        --primary-color: #4a6fa5;
        --secondary-color: #166088;
        --accent-color: #4fc3f7;
        --light-color: #f8f9fa;
        --dark-color: #343a40;
    }

    body {
        font-family: 'Georgia', serif;
        background-color: #f9f5f0;
    }

    .book-card {
        transition: transform 0.3s, box-shadow 0.3s;
        margin-bottom: 20px;
        height: 100%;
    }

    .book-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    footer {
        background-color: var(--dark-color);
        color: white;
        padding: 2rem 0;
        margin-top: 3rem;
    }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">