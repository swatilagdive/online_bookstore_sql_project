-- 
CREATE TABLE BOOKS(
     BOOK_ID INT PRIMARY KEY,
     Title VARCHAR(100),
     Author VARCHAR(100),
     Gener VARCHAR(50),
     Publish_year INT,
     Price NUMERIC(10,2),
     Stock INT);

 
-- 
CREATE TABLE Customers(
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone varchar(15),
    City VARCHAR(50),
    Country VARCHAR(150));
    
--


CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

