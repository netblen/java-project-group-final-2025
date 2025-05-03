<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Books Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 8px 12px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f4f4f4;
        }

        button {
            padding: 5px 10px;
            margin: 2px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            box-sizing: border-box;
        }
    </style>
    <script>
        async function loadBooks() {
            const response = await fetch('books');
            const books = await response.json();


            const tableBody = document.getElementById('book-table-body');
            tableBody.innerHTML = "";

            books.forEach(book => {
                const row = document.createElement('tr');

                const titleCell = document.createElement('td');
                const titleInput = document.createElement('input');
                titleInput.type = 'text';
                titleInput.value = book.title;
                titleInput.onchange = () => updateValue(titleInput, book.bookId, 'title');
                titleCell.appendChild(titleInput);

                const authorCell = document.createElement('td');
                const authorInput = document.createElement('input');
                authorInput.type = 'text';
                authorInput.value = book.author;
                authorInput.onchange = () => updateValue(authorInput, book.bookId, 'author');
                authorCell.appendChild(authorInput);

                const priceCell = document.createElement('td');
                const priceInput = document.createElement('input');
                priceInput.type = 'number';
                priceInput.value = book.bookPrice;
                priceInput.onchange = () => updateValue(priceInput, book.bookId, 'bookPrice');
                priceCell.appendChild(priceInput);

                const stockCell = document.createElement('td');
                const stockInput = document.createElement('input');
                stockInput.type = 'number';
                stockInput.value = book.stock;
                stockInput.onchange = () => updateValue(stockInput, book.bookId, 'stock');
                stockCell.appendChild(stockInput);

                const availableCell = document.createElement('td');
                const availableCheckbox = document.createElement('input');
                availableCheckbox.type = 'checkbox';
                availableCheckbox.checked = book.available;
                availableCheckbox.onchange = () => updateCheckbox(book.bookId, 'available', availableCheckbox.checked);
                availableCell.appendChild(availableCheckbox);


                const genresCell = document.createElement('td');
                genresCell.textContent = book.genres.join(", ");

                const actionsCell = document.createElement('td');
                const deleteButton = document.createElement('button');
                deleteButton.textContent = '🗑️';
                deleteButton.onclick = () => deleteBook(book.bookId);
                actionsCell.appendChild(deleteButton);

                row.appendChild(titleCell);
                row.appendChild(authorCell);
                row.appendChild(priceCell);
                row.appendChild(stockCell);
                row.appendChild(availableCell);
                row.appendChild(genresCell);
                row.appendChild(actionsCell);

                tableBody.appendChild(row);
            });

            console.log("Books loaded:", books);
        }

        async function deleteBook(bookId) {
            const confirmed = confirm("Are you sure you want to delete this book?");
            if (!confirmed) return;

            await fetch('books?code=' + bookId, {
                method: 'DELETE'
            });
            loadBooks();
        }

        async function updateCheckbox(bookId, field, value) {
            const res = await fetch('books?code=' + bookId);
            const book = await res.json();

            book[field] = value;

            await fetch('books', {
                method: 'PUT',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(book)
            });

            loadBooks();
        }


        async function addBook() {
            const title = document.getElementById('new-title').value;
            const author = document.getElementById('new-author').value;
            const price = parseFloat(document.getElementById('new-price').value);
            const stock = parseInt(document.getElementById('new-stock').value);
            const available = document.getElementById('new-available').checked;
            const genresStr = document.getElementById('new-genres').value;
            const genres = genresStr.split(',').map(g => g.trim()).filter(g => g.length > 0);

            const newBook = {
                title,
                author,
                bookPrice: price,
                stock,
                available,
                genres
            };

            await fetch('books', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(newBook)
            });

            document.getElementById('add-book-form').reset(); // clear form
            loadBooks(); // reload the list
            return false; // prevent page reload
        }

        async function updateValue(input, bookId, field) {
            const res = await fetch('books?code=' + bookId);
            const book = await res.json();
            book[field] = input.type === "number" ? parseFloat(input.value) : input.value;
            if (typeof book.available !== 'boolean') {
                book.available = false;
            }

            if (!Array.isArray(book.genres)) {
                book.genres = [];
            }

            console.log("Sending PUT with book:", JSON.stringify(book, null, 2));

            const response = await fetch('books', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(book)
            });

            if (!response.ok) {
                const errorText = await response.text();
                console.error("PUT failed:", response.status, errorText);
            }

            loadBooks();
        }



        window.onload = loadBooks;

    </script>
</head>
<body>
<h1>📚 Book Manager</h1>
<h2>➕ Add New Book</h2>
<form id="add-book-form" onsubmit="return addBook();">
    <table>
        <tr>
            <td><input type="text" id="new-title" placeholder="Title" required></td>
            <td><input type="text" id="new-author" placeholder="Author" required></td>
            <td><input type="number" id="new-price" placeholder="Price" required></td>
            <td><input type="number" id="new-stock" placeholder="Stock" required></td>
            <td><input type="checkbox" id="new-available"></td>
            <td><input type="text" id="new-genres" placeholder="Genres (comma-separated)" required></td>
            <td>
                <button type="submit">➕ Add</button>
            </td>
        </tr>
    </table>
</form>

<table>
    <thead>
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Price ($)</th>
        <th>Stock</th>
        <th>Available</th>
        <th>Genres</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody id="book-table-body">
    <!-- Rows will be loaded here dynamically -->
    </tbody>
</table>
</body>
</html>
