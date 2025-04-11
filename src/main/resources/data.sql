-- GENRES
INSERT INTO Genre (genreName) VALUES ('Fiction'), ('Non-Fiction'), ('Science'), ('Fantasy'), ('History');

-- BOOKS
INSERT INTO Books (title, author, bookPrice, stock, isAvailable)
VALUES
    ('1984', 'George Orwell', 15.99, 10, TRUE),
    ('A Brief History of Time', 'Stephen Hawking', 20.00, 5, TRUE),
    ('The Hobbit', 'J.R.R. Tolkien', 12.50, 8, TRUE),
    ('The Art of War', 'Sun Tzu', 8.99, 15, TRUE);

-- INVENTORY
INSERT INTO Inventory (bookId, inventoryQuantity)
VALUES
    (1, 10),
    (2, 5),
    (3, 8),
    (4, 15);

-- BOOK_GENRES
INSERT INTO Book_Genres (bookId, genreId) VALUES
                                              (1, 1), -- 1984 -> Fiction
                                              (2, 3), -- Brief History -> Science
                                              (3, 4), -- Hobbit -> Fantasy
                                              (4, 5); -- Art of War -> History

-- CUSTOMERS
INSERT INTO Customer (name, email, password, userType)
VALUES
    ('Alice Johnson', 'alice@example.com', 'alice123', 'regular'),
    ('Bob Smith', 'bob@example.com', 'bob123', 'regular');

-- ADMIN
INSERT INTO Admin (actionType) VALUES ('Created system'), ('Initialized inventory');

-- ORDERS
INSERT INTO Orders (customerId, totalPrice, orderStatus)
VALUES
    (1, 27.49, 'Shipped'),
    (2, 12.50, 'Processing');

-- ORDER DETAILS
INSERT INTO Order_Details (orderId, bookId, orderQuantity, orderPrice)
VALUES
    (1, 1, 1, 15.99), -- Alice ordered 1984
    (1, 4, 1, 8.99),  -- Alice ordered Art of War
    (2, 3, 1, 12.50); -- Bob ordered The Hobbit

-- SHOPPING CART
INSERT INTO ShoppingCart (customerId)
VALUES
    (1),
    (2);

-- SHOPPING CART ITEMS
INSERT INTO ShoppingCart_Items (cartId, bookId, shoppingCartQuantity)
VALUES
    (1, 2, 1), -- Alice cart: Brief History
    (2, 1, 2); -- Bob cart: 1984 x2