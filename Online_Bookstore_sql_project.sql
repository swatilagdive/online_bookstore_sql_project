SELECT * FROM online_bookstore.books;
use online_bookstore;
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM  books
WHERE Genre = 'Fiction';


-- 2) Find books published after the year 1950:
	SELECT  * from books
    WHERE Published_Year >=1950;
    

-- 3) List all customers from the Canada:
    select * from customers
    WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023:

select * from orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) as 'Total_stock' from books;

-- 6) Find the details of the most expensive book:
SELECT * from books
order by price DESC LIMIT 1;

-- OR subquery
SELECT * FROM books WHERE Price  = (SELECT MAX(Price) FROM books);

-- OR window function
SELECT * 
FROM 
	(
	SELECT *,
	RANK() OVER(ORDER BY Price DESC) AS Expensive_Book
	FROM books
	) t
WHERE t.Expensive_Book = 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT Name,Quantity
		FROM orders O
        JOIN customers C 
        ON O.Customer_ID = C.Customer_ID
        WHERE Quantity > 1; 
        

-- 8) Retrieve all orders where the total amount exceeds $20:
  SELECT * FROM orders
  WHERE Total_Amount > 20;
  
  
 SELECT * FROM orders
  WHERE Total_Amount < 20;
  
-- 9) List all genres available in the Books table:
SELECT distinct(Genre) FROM books;

-- 10) Find the book with the lowest stock:

SELECT MIN(Stock) AS 'LOWEST STOCK' FROM books;
-- OR
SELECT * FROM books
ORDER BY Stock LIMIT 1;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT sum(Quantity) as 'total_number_book' from orders
group by genre;

USE online_bookstore;
SELECT SUM(Total_Quantity_Sold)
FROM
	(
	SELECT t1.Book_ID,t1.Genre,SUM(t2.Quantity) AS 'Total_Quantity_Sold'
	FROM books t1
	JOIN orders t2 
	ON t1.Book_ID = t2.Book_ID
	GROUP BY t1.Book_ID,t1.Genre
	ORDER BY SUM(t2.Quantity) DESC
	) t;
    
SELECT SUM(Quantity) FROM orders;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price) ,genre FROM BOOKS
WHERE genre = "Fantasy";

-- 3) List customers who have placed at least 2 orders:

SELECT c.Customer_ID,Name,Quantity
	FROM orders o
    JOIN customers c
    ON o.Customer_ID = c.Customer_ID
    WHERE Quantity >= 2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_ID,b.Title,SUM(o.Quantity) 
FROM orders o
JOIN books b
ON o.Book_ID =b.Book_ID
GROUP BY o.Book_ID,b.Title
ORDER BY SUM(o.Quantity) DESC limit 1;

select sum(Quantity) from orders;


-- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
where genre ='Fantasy'
order by Price desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.Author,SUM(o.Quantity) as total_quantity_book
FROM books b 
JOIN orders o
ON b.Book_ID =o.Book_ID
GROUP BY b.Author;



-- 7) List the cities where customers who spent over $30 are located:

SELECT c.city, total_amount
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;



-- 8) Find the customer who spent the most on orders:
SELECT c.Name,c.Customer_ID,SUM(Total_Amount)
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
GROUP BY c.Name,c.Customer_ID
ORDER BY  SUM(Total_Amount)DESC LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT COUNT(DISTINCT Title)
FROM
(
SELECT t2.Book_ID,t2.Title,t2.Stock,t2.Stock - COALESCE(SUM(t1.Quantity),0) AS 'Remaning_Stock'
FROM orders t1
RIGHT JOIN books t2
ON t1.Book_ID = t2.Book_ID
GROUP BY t2.Book_ID,t2.Title,t2.Stock
HAVING Remaning_Stock IS NOT  NULL AND t2.Stock =  Remaning_Stock
ORDER BY Remaning_Stock DESC
) t










