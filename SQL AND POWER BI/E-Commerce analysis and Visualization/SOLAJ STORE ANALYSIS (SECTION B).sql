
--- SECTION B----

use solaj;

--- TOTAL NUMBER OF PRODUCT SOLD SO FAR----
select count(*) as "Total Number of Product"
from product;

--- 2. Total Number of Revenue---
select * from product;
select * from order_details;
select round(sum(price*quantity),2) as "Total Revenue"
from order_details as od
inner join product as p on p.ProductID = od.ProductID;

--- 3. Total Unique Products sold based on category ----
select distinct Product_name, od.productID, Category_name
from categories as c
inner join product as p on p.CategoryID = c.CategoryID
inner join order_details as od on od.ProductID = p.ProductID;

--- 4. TOTAL NUMBER OF PURCHASE TRANSACTION FROM CUSTOMER -----
select count(order_id) as "Total Number of Purchase"
from orders;

--- 5. COMPARE ORDERS MADE BETWEEN 2022-2023 --- 
select * from orders;
select year(orderdate), count(order_id)
from orders
group by(year(orderdate));

--- 6. WHAT IS THE TOTAL NUMBER OF CUSTOMERS? COMPARE THOSE THAT HAVE MADE TRANSACTIONS AND THOSE THAT HAVENT AT ALL (x) ---
select * from customer;
select count(customerid) as "Total Number of Customer"
from customer;
select count(c.customerid) as "No. of Customer",
       case
         when o.Customer_ID IS NULL THEN 'Yet to make an Order'
         else 'Made an Order'
       end as TransactionStatus
from Customer as c
left join orders as o on c.customerID = o.Customer_Id
group by TransactionStatus;

--- 7. WHO ARE THE TOP 5 CUSTOMERS WITH THE HIGHEST PURCHASE VALUE--- 
select * from customer;
select * from orders;
Select count(c.CustomerID) as "Customer ID", Customer_Name as "Customer Name", Round(sum(Price * Quantity), 2) as "Purchase Amount"
from customer as c
inner join orders as o on o.Customer_ID = c.CustomerID
inner join order_details as od on od.OrderID= o.Order_ID
inner join product as p on p.ProductID = od.ProductID
group by c.CustomerID
order by sum(price) desc
limit 5;

--- 8. Top 5 best-selling products---
select (productID), sum(quantity)
from Order_details
group by productID
order by sum(quantity) desc
limit 5;
 
--- 9. WHAT IS THE TRANSACTION VALUE PER MONTH---
select concat(month(OrderDate), "-", year(OrderDate)) as "Month-Year" ,count(o.Order_ID) as "No of Orders", sum(price) as "Total Amount"
from Orders as o
inner join order_details as od on o.Order_ID = od.OrderID
inner join product as p on p.ProductID = od.ProductID
group by concat(month(OrderDate), "-", year(OrderDate));

--- 10. BEST SELLING PRODUCT CATEGORY ---
select c.CategoryID, Category_name, count(OrderID) as "Number of Orders"
from categories as c
inner join Product as p on p.CategoryID = c. CategoryID
inner join order_details as od on od.ProductID = p.ProductID
group by CategoryID
order by count(OrderID) desc;

select * from product;

--- 11. BUYERS WHO HAVE TRANSACTED MORE THAN TWO TIMES---
select Customer_id, count(Order_id)
from orders
group by (Customer_id)
having count(Order_id) > 2;

--- 12. MOST SUCCESSFUL EMPLOYEE ---
select count(Order_id) as "No of Orders", e.EmployeeID
from employees as e
inner join orders as o on o.EmployeeID = e.EmployeeID
group by e.EmployeeID
order by count(Order_id) desc
limit 1;

--- 13. MOST USED SHIPPER ---
Select s.ShipperID, Shipper_name, count(Order_id) as "No of Orders"
from shippers as s
inner join orders as o on o.ShipperID = s.ShipperID
group by ShipperID 
order by count(Order_id) desc
limit 1;

--- 14. MOST USED SUPPLIER---
Select s.supplierID, Supplier_name, count(o.Order_id) as "No Of Orders"
from Supplier as s
inner join Product as p on p.SupplierID = s.SupplierID
inner join order_details as od on od.ProductID = p.productID
inner join orders as o on o.Order_id = od.Orderid
group by s.supplierID
order by count(o.Order_ID) desc
limit 1;


