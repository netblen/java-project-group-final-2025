CREATE TABLE IF NOT EXISTS Books (
    bookId INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    bookPrice DOUBLE,
    stock INT,
    isAvailable BOOLEAN
);
