-- Table: Books
CREATE TABLE IF NOT EXISTS Books
(
    bookId      INT PRIMARY KEY,
    title       VARCHAR(255),
    author      VARCHAR(255),
    genre       VARCHAR(100),
    bookPrice   DOUBLE,
    stock       INT,
    isAvailable BOOLEAN
);

-- Table: Genre
CREATE TABLE IF NOT EXISTS Genre
(
    genreId   INT PRIMARY KEY,
    genreName VARCHAR(100)
);

-- Table: Book_Genres (relation between Books and Genre)
CREATE TABLE IF NOT EXISTS Book_Genres
(
    bookId  INT,
    genreId INT,
    PRIMARY KEY (bookId, genreId),
    FOREIGN KEY (bookId) REFERENCES Books (bookId),
    FOREIGN KEY (genreId) REFERENCES Genre (genreId)
);

-- Table: Inventory
CREATE TABLE IF NOT EXISTS Inventory
(
    bookId            INT PRIMARY KEY,
    inventoryQuantity INT,
    FOREIGN KEY (bookId) REFERENCES Books (bookId)
);

-- Table: Customer
CREATE TABLE IF NOT EXISTS Customer
(
    customerId INT PRIMARY KEY,
    name       VARCHAR(100),
    email      VARCHAR(100),
    password   VARCHAR(255),
    userType   VARCHAR(50)
);

-- Table: Admin
CREATE TABLE IF NOT EXISTS Admin
(
    adminId    INT PRIMARY KEY,
    actionType VARCHAR(100),
    actionDate TIMESTAMP
);

-- Table: Orders
CREATE TABLE IF NOT EXISTS Orders
(
    orderId     INT PRIMARY KEY,
    customerId  INT,
    totalPrice  DOUBLE,
    orderDate   TIMESTAMP,
    orderStatus VARCHAR(50),
    FOREIGN KEY (customerId) REFERENCES Customer (customerId)
);

-- Table: Order_Details
CREATE TABLE IF NOT EXISTS Order_Details
(
    orderId       INT,
    bookId        INT,
    orderQuantity INT,
    orderPrice    DOUBLE,
    PRIMARY KEY (orderId, bookId),
    FOREIGN KEY (orderId) REFERENCES Orders (orderId),
    FOREIGN KEY (bookId) REFERENCES Books (bookId)
);

-- Table: ShoppingCart
CREATE TABLE IF NOT EXISTS ShoppingCart
(
    cartId     INT PRIMARY KEY,
    customerId INT,
    createdAt  TIMESTAMP,
    FOREIGN KEY (customerId) REFERENCES Customer (customerId)
);

-- Table: ShoppingCart_Items
CREATE TABLE IF NOT EXISTS ShoppingCart_Items
(
    cartId               INT,
    bookId               INT,
    shoppingCartQuantity INT,
    PRIMARY KEY (cartId, bookId),
    FOREIGN KEY (cartId) REFERENCES ShoppingCart (cartId),
    FOREIGN KEY (bookId) REFERENCES Books (bookId)
);
