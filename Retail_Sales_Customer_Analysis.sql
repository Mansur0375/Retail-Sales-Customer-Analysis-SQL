-- Retail Sales and Customer Analysis | SQLite | 80-query portfolio collection
-- Run numbered queries one at a time. Revenue = quantity * product price (SAR).

-- STEP 01: All customers
SELECT * FROM Customers;

-- STEP 02: All products
SELECT * FROM Products;

-- STEP 03: All orders
SELECT * FROM Orders;

-- STEP 04: All order details
SELECT * FROM OrderDetails;

-- STEP 05: Customer names alphabetically
SELECT Customer_name FROM Customers ORDER BY Customer_name;

-- STEP 06: Unique cities
SELECT DISTINCT City FROM Customers ORDER BY City;

-- STEP 07: Unique categories
SELECT DISTINCT Category FROM Products ORDER BY Category;

-- STEP 08: Products price high to low
SELECT Product_name,Price FROM Products ORDER BY Price DESC;

-- STEP 09: Products price low to high
SELECT Product_name,Price FROM Products ORDER BY Price;

-- STEP 10: Products above SAR 500
SELECT Product_name,Price FROM Products WHERE Price>500;

-- STEP 11: Products between SAR 200 and 2000
SELECT Product_name,Price FROM Products WHERE Price BETWEEN 200 AND 2000;

-- STEP 12: Product name contains phone
SELECT * FROM Products WHERE Product_name LIKE '%phone%';

-- STEP 13: Customers in Riyadh
SELECT * FROM Customers WHERE City='Riyadh';

-- STEP 14: Customers in Jeddah
SELECT * FROM Customers WHERE City='Jeddah';

-- STEP 15: Saudi customers
SELECT * FROM Customers WHERE Country='Saudi Arabia';

-- STEP 16: Orders by date
SELECT * FROM Orders ORDER BY order_date;

-- STEP 17: Orders in January 2026
SELECT * FROM Orders WHERE order_date>='2026-01-01' AND order_date<'2026-02-01';

-- STEP 18: Orders in February 2026
SELECT * FROM Orders WHERE order_date>='2026-02-01' AND order_date<'2026-03-01';

-- STEP 19: Orders in March 2026
SELECT * FROM Orders WHERE order_date>='2026-03-01' AND order_date<'2026-04-01';

-- STEP 20: Customers with names starting M
SELECT * FROM Customers WHERE Customer_name LIKE 'M%';

-- STEP 21: Count customers
SELECT COUNT(*) Customer_Count FROM Customers;

-- STEP 22: Count products
SELECT COUNT(*) Product_Count FROM Products;

-- STEP 23: Count orders
SELECT COUNT(*) Order_Count FROM Orders;

-- STEP 24: Count order details
SELECT COUNT(*) Detail_Count FROM OrderDetails;

-- STEP 25: Min and max product price
SELECT MIN(Price) Min_Price,MAX(Price) Max_Price FROM Products;

-- STEP 26: Average product price
SELECT ROUND(AVG(Price),2) Avg_Price FROM Products;

-- STEP 27: Units sold
SELECT SUM(quantity) Units_Sold FROM OrderDetails;

-- STEP 28: Total sales revenue
SELECT SUM(od.quantity*p.Price) Revenue FROM OrderDetails od JOIN Products p ON od.product_id=p.Product_id;

-- STEP 29: Revenue by product
SELECT p.Product_name,SUM(od.quantity*p.Price) Revenue FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Product_id,p.Product_name ORDER BY Revenue DESC;

-- STEP 30: Units by product
SELECT p.Product_name,SUM(od.quantity) Units FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Product_id,p.Product_name ORDER BY Units DESC;

-- STEP 31: Revenue by category
SELECT p.Category,SUM(od.quantity*p.Price) Revenue FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Category ORDER BY Revenue DESC;

-- STEP 32: Products per category
SELECT Category,COUNT(*) Product_Count FROM Products GROUP BY Category;

-- STEP 33: Categories with more than one product
SELECT Category,COUNT(*) Product_Count FROM Products GROUP BY Category HAVING COUNT(*)>1;

-- STEP 34: Orders with customer names
SELECT o.order_id,o.order_date,c.Customer_name FROM Orders o JOIN Customers c ON o.customer_id=c.Customer_id;

-- STEP 35: Order detail with product name
SELECT od.order_id,p.Product_name,od.quantity,p.Price FROM OrderDetails od JOIN Products p ON od.product_id=p.Product_id;

-- STEP 36: Customer city and order date
SELECT o.order_id,o.order_date,c.Customer_name,c.City FROM Orders o JOIN Customers c ON o.customer_id=c.Customer_id;

-- STEP 37: Order totals
SELECT o.order_id,SUM(od.quantity*p.Price) Order_Total FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY o.order_id;

-- STEP 38: Order totals with customer
SELECT o.order_id,c.Customer_name,c.City,SUM(od.quantity*p.Price) Total FROM Orders o JOIN Customers c ON o.customer_id=c.Customer_id JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY o.order_id,c.Customer_name,c.City;

-- STEP 39: Average order value
SELECT ROUND(AVG(total),2) AOV FROM (SELECT o.order_id,SUM(od.quantity*p.Price) total FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY o.order_id);

-- STEP 40: Revenue by city
SELECT c.City,SUM(od.quantity*p.Price) Revenue FROM Customers c JOIN Orders o ON c.Customer_id=o.customer_id JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY c.City ORDER BY Revenue DESC;

-- STEP 41: Revenue by customer
SELECT c.Customer_name,SUM(od.quantity*p.Price) Revenue FROM Customers c JOIN Orders o ON c.Customer_id=o.customer_id JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY c.Customer_id,c.Customer_name ORDER BY Revenue DESC;

-- STEP 42: Order count by customer
SELECT c.Customer_name,COUNT(o.order_id) Orders_Count FROM Customers c LEFT JOIN Orders o ON c.Customer_id=o.customer_id GROUP BY c.Customer_id,c.Customer_name;

-- STEP 43: Customers with no orders
SELECT c.* FROM Customers c LEFT JOIN Orders o ON c.Customer_id=o.customer_id WHERE o.order_id IS NULL;

-- STEP 44: Products never ordered
SELECT p.* FROM Products p LEFT JOIN OrderDetails od ON p.Product_id=od.product_id WHERE od.product_id IS NULL;

-- STEP 45: Orders with multiple detail rows
SELECT order_id,COUNT(*) Detail_Lines FROM OrderDetails GROUP BY order_id HAVING COUNT(*)>1;

-- STEP 46: Orders with total quantity above two
SELECT order_id,SUM(quantity) Qty FROM OrderDetails GROUP BY order_id HAVING SUM(quantity)>2;

-- STEP 47: Monthly revenue
SELECT substr(o.order_date,1,7) Month,SUM(od.quantity*p.Price) Revenue FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY Month ORDER BY Month;

-- STEP 48: Yearly revenue
SELECT substr(o.order_date,1,4) Year,SUM(od.quantity*p.Price) Revenue FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY Year;

-- STEP 49: Monthly order count
SELECT substr(order_date,1,7) Month,COUNT(*) Orders FROM Orders GROUP BY Month ORDER BY Month;

-- STEP 50: Price bands with CASE
SELECT Product_name,Price,CASE WHEN Price>=2000 THEN 'High' WHEN Price>=500 THEN 'Medium' ELSE 'Low' END Price_Band FROM Products;

-- STEP 51: Order size with CASE
SELECT order_id,SUM(quantity) Qty,CASE WHEN SUM(quantity)>=3 THEN 'Large' WHEN SUM(quantity)=2 THEN 'Medium' ELSE 'Small' END Order_Size FROM OrderDetails GROUP BY order_id;

-- STEP 52: Products above average price
SELECT Product_name,Price FROM Products WHERE Price>(SELECT AVG(Price) FROM Products);

-- STEP 53: Customers with orders using EXISTS
SELECT c.Customer_name FROM Customers c WHERE EXISTS(SELECT 1 FROM Orders o WHERE o.customer_id=c.Customer_id);

-- STEP 54: Highest priced product
SELECT * FROM Products WHERE Price=(SELECT MAX(Price) FROM Products);

-- STEP 55: Lowest priced product
SELECT * FROM Products WHERE Price=(SELECT MIN(Price) FROM Products);

-- STEP 56: Cities with revenue above SAR 3000
SELECT c.City,SUM(od.quantity*p.Price) Revenue FROM Customers c JOIN Orders o ON c.Customer_id=o.customer_id JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY c.City HAVING Revenue>3000;

-- STEP 57: Customers with repeat orders
SELECT c.Customer_name,COUNT(o.order_id) Orders_Count FROM Customers c JOIN Orders o ON c.Customer_id=o.customer_id GROUP BY c.Customer_id,c.Customer_name HAVING COUNT(o.order_id)>1;

-- STEP 58: Products with more than one unit sold
SELECT p.Product_name,SUM(od.quantity) Units FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Product_id,p.Product_name HAVING SUM(od.quantity)>1;

-- STEP 59: Latest order date by customer
SELECT customer_id,MAX(order_date) Latest_Order FROM Orders GROUP BY customer_id;

-- STEP 60: Order detail quantities above average
SELECT * FROM OrderDetails WHERE quantity>(SELECT AVG(quantity) FROM OrderDetails);

-- STEP 61: Cities with name containing dam
SELECT DISTINCT City FROM Customers WHERE lower(City) LIKE '%dam%';

-- STEP 62: Rank products by revenue
SELECT Product_name,Revenue,RANK() OVER(ORDER BY Revenue DESC) Revenue_Rank FROM (SELECT p.Product_name,SUM(od.quantity*p.Price) Revenue FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Product_id,p.Product_name);

-- STEP 63: Sequence orders by date
SELECT order_id,order_date,ROW_NUMBER() OVER(ORDER BY order_date,order_id) Order_Sequence FROM Orders;

-- STEP 64: Running revenue by order
SELECT order_id,order_date,Order_Revenue,SUM(Order_Revenue) OVER(ORDER BY order_date,order_id) Running_Revenue FROM (SELECT o.order_id,o.order_date,SUM(od.quantity*p.Price) Order_Revenue FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY o.order_id,o.order_date);

-- STEP 65: Previous month revenue
SELECT Month,Revenue,LAG(Revenue) OVER(ORDER BY Month) Previous_Revenue FROM (SELECT substr(o.order_date,1,7) Month,SUM(od.quantity*p.Price) Revenue FROM Orders o JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY Month);

-- STEP 66: Rounded product prices
SELECT Product_name,ROUND(Price,0) Rounded_Price FROM Products;

-- STEP 67: Revenue percentage by product
SELECT Product_name,Revenue,ROUND(100.0*Revenue/(SELECT SUM(od.quantity*p.Price) FROM OrderDetails od JOIN Products p ON od.product_id=p.Product_id),2) Revenue_Percent FROM (SELECT p.Product_name,SUM(od.quantity*p.Price) Revenue FROM Products p JOIN OrderDetails od ON p.Product_id=od.product_id GROUP BY p.Product_id,p.Product_name);

-- STEP 68: Revenue percentage by city
SELECT City,Revenue,ROUND(100.0*Revenue/(SELECT SUM(od.quantity*p.Price) FROM OrderDetails od JOIN Products p ON od.product_id=p.Product_id),2) Revenue_Percent FROM (SELECT c.City,SUM(od.quantity*p.Price) Revenue FROM Customers c JOIN Orders o ON c.Customer_id=o.customer_id JOIN OrderDetails od ON o.order_id=od.order_id JOIN Products p ON od.product_id=p.Product_id GROUP BY c.City);

-- STEP 69: Check duplicate customer names
SELECT Customer_name,COUNT(*) Cnt FROM Customers GROUP BY Customer_name HAVING COUNT(*)>1;

-- STEP 70: Check duplicate order IDs
SELECT order_id,COUNT(*) Cnt FROM Orders GROUP BY order_id HAVING COUNT(*)>1;

-- STEP 71: Check duplicate detail IDs
SELECT order_detail_id,COUNT(*) Cnt FROM OrderDetails GROUP BY order_detail_id HAVING COUNT(*)>1;

-- STEP 72: Orders with unmatched customer
SELECT o.* FROM Orders o LEFT JOIN Customers c ON o.customer_id=c.Customer_id WHERE c.Customer_id IS NULL;

-- STEP 73: Details with unmatched product
SELECT od.* FROM OrderDetails od LEFT JOIN Products p ON od.product_id=p.Product_id WHERE p.Product_id IS NULL;

-- STEP 74: Details with unmatched order
SELECT od.* FROM OrderDetails od LEFT JOIN Orders o ON od.order_id=o.order_id WHERE o.order_id IS NULL;

-- STEP 75: Blank customer names
SELECT * FROM Customers WHERE Customer_name IS NULL OR trim(Customer_name)='';

-- STEP 76: Blank product names
SELECT * FROM Products WHERE Product_name IS NULL OR trim(Product_name)='';

-- STEP 77: Nonpositive product prices
SELECT * FROM Products WHERE Price<=0;

-- STEP 78: Nonpositive order quantities
SELECT * FROM OrderDetails WHERE quantity<=0;

-- STEP 79: Find electronics category spelling variants
SELECT DISTINCT Category FROM Products WHERE lower(Category) LIKE '%electron%';

-- STEP 80: Uppercase category names
SELECT Product_name,UPPER(Category) Category_Upper FROM Products;
