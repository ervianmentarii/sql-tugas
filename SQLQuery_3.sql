show DATABASES;
SHOW TABLES;
CREATE DATABASE online_bookstore;
use online_bookstore;
DROP TABLE book;
CREATE TABLE author(
author_id int PRIMARY KEY,
author_name VARCHAR(100) NOT NULL
)ENGINE=Innodb;

CREATE TABLE publisher(
publisher_id INT  PRIMARY KEY,
publisher_name VARCHAR(100) NOT NULL
)ENGINE=Innodb;

CREATE TABLE book(
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id int,
    publisher_id int,
    FOREIGN KEY(author_id) REFERENCES author(author_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    price DECIMAL(10,2) NOT NULL,
    publication_date DATE
)ENGINE=Innodb;

CREATE TABLE customer(
    costumer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT null,
    email VARCHAR(100) UNIQUE,
    address TEXT 
)ENGINE=Innodb;

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    costumer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    check(quantity>=1 AND quantity<=10)
)ENGINE=Innodb;

ALTER TABLE customer
ADD country VARCHAR(50);

ALTER TABLE book
ADD CONSTRAINT FK_publisher 
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id);

ALTER TABLE author
RENAME COLUMN author_name to full_name;

ALTER TABLE orders
MODIFY quantity INT NOT NULL;

ALTER TABLE orders
ADD CONSTRAINT fk_customer FOREIGN key(costumer_id) REFERENCES customer(costumer_id)ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES book(book_id)ON DELETE CASCADE ON UPDATE CASCADE; 


ALTER TABLE customer
DROP COLUMN country;

ALTER TABLE book
DROP COLUMN publisher_id ;

DROP TABLE publisher;
DESC book;
show tables;

insert INTO author(author_id,full_name) VALUES (1, 'J.K. Rowling'),
(2, 'George Orwell'),
(3, 'Jane Austen'),
(4, 'Mark Twain'),
(5, 'Agatha Christie');

INSERT INTO book(book_id,title,author_id, price,publication_date) VALUES (1, 'Harry Potter and the Sorcerer\'s Stone', 1, 19.99, '2001-06-26'),
(2, '1984', 2, 15.5, '1949-06-08'),
(3, 'Pride and Prejudice', 3, 12.75, '1813-01-28'),
(4, 'The Adventures of Tom Sawyer', 4, 10.0, '1876-06-01'),
(5, 'Murder on the Orient Express', 5, 14.25, '1934-01-01');



INSERT INTO customer(costumer_id,first_name,email,address) VALUES
(1, 'Alice', 'alice@example.com', '123 Main St, Springfield'),
(2, 'Bob', 'bob@example.com', '456 Elm St, Shelbyville'),
(3, 'Charlie', 'charlie@example.com', '789 Oak St, Capital City'),
(4, 'Diana', 'diana@example.com', '101 Pine St, Ogdenville'),
(5, 'Ethan', 'ethan@example.com', '202 Maple St, North Haverbrook');
select * FROM book;

INSERT INTO orders (order_id, costumer_id, book_id, order_date, quantity) VALUES
(1, 1, 1, '2024-01-10', 2),
(2, 2, 3, '2024-02-15', 1),
(3, 3, 2, '2024-03-20', 5),
(4, 4, 5, '2024-04-25', 3),
(5, 5, 4, '2024-05-05', 4);

UPDATE book
SET price=155000
WHERE  title= 'Harry Potter and the Sorcerer\'s Stone';
select * from customer;

UPDATE customer
SET first_name='carlos',address='celle de la princesa,marid,spain'
where costumer_id=1;

UPDATE orders
SET quantity=3
WHERE  order_id=1;
select * from orders;


UPDATE author
SET full_name='franz kafka'
WHERE  author_id=1;
select * from orders;

DELETE FROM orders WHERE quantity>=5;
DELETE FROM customer WHERE email LIKE '%diana%';


delete FROM book WHERE publication_date < '1934-01-01';