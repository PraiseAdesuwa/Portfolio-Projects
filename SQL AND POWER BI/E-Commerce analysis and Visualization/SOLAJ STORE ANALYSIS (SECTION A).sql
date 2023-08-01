--- SECTION A ---
--- 1. Select customer name together with each order the customer made---
Select customer_name, order_id
from customer as c
inner join orders as o on c.CustomerID = o.Customer_id;

--- 2. Select order id together with name of employee who handled the order---
select order_id, concat(firstname, lastname) as "Employee name"
from orders as o
inner join employees as e on e.EmployeeID = e.EmployeeID;

--- 3. Select customers who did not placed any order yet---
select c.CustomerID, c.Customer_Name
from customer as c
left join orders as o on c.CustomerID = o.Customer_ID
where o.Customer_ID is null;

--- 4. Select order id together with the name of products---
select orderID, Product_name
from order_details as od
inner join product as p on od.ProductID = p.ProductID;
select * from order_details;
select * from product;

--- 5. Select products that no one bought---
select *
from product
where ProductID not IN (select productid from order_details);

--- 6. Select customer together with the products that he bought---
select c.CustomerID, c.Contact_Name, p.productID, p.product_Name
from customer as c
inner join orders as o on c.CustomerID = o.Customer_ID
inner join order_details as od on o.order_id = od.orderid
inner join product as p on od.productid = p.productid;

--- 7. Select product names together with the name of corresponding category---
select product_name, Category_Name
from categories as c
inner join product as p on c.CategoryID = p.CategoryID;

--- 8. Select orders together with the name of the shipping company---
select order_id, shipper_name
from orders as o
inner join shippers as s on o.ShipperID = s.ShipperID;
select * from orders;
select * from shippers;

--- 9. Select customers with id greater than 50 together with each order they made---
select c.CustomerID, Customer_Name, order_id
from orders as o
inner join customer as c on o.Customer_ID = c.CustomerID
where c.CustomerID > 50;

--- 10. Select employees together with orders with order id greater than 10400---
select e.EmployeeID, LastName, FirstName, Order_ID
from employees as e
right join orders as o on e.EmployeeID = o.EmployeeID
where Order_ID > 10400;

--- 11. Select the most expensive product---
select ProductID, Product_Name, Unit, price
from product
Order by Price Desc
limit 1;

--- 12. Select the second most expensive product---
select  ProductID, Product_Name, Unit, price
from product
Order by Price Desc
limit 1,1;

--- 13. Select name and price of each product, sort the result by price in decreasing order---
select Product_Name, Price
from product
order by Price desc;

--- 14. Select 5 most expensive products---
select *
from product
Order by Price Desc
limit 5;

--- 15. Select 5 most expensive products without the most expensive (in final 4 products)---
select *
from product
Order by Price Desc
limit 1,5;

--- 16. Select name of the cheapest product (only name) without using LIMIT and OFFSET---
SELECT p1.Product_Name
FROM product as p1
LEFT JOIN product as p2 ON p1.price > p2.price
WHERE p2.price IS NULL;

--- 17. Select name of the cheapest product (only name) using subquery---
select Product_Name
from product 
where price = 
(select min(price) from product);

--- 18. Select number of employees with LastName that starts with 'D'---
select count(EmployeeID)
from employees
where LastName like ' D%';

--- 19. Select customer name together with the number of orders made by the corresponding
-- customer, sort the result by number of orders in decreasing order---
select c.customerid, Customer_Name, count(order_ID) as "Number of Orders"
from customer as c
inner join orders as o on c.customerID = o.customer_ID
group by CustomerID
order by count(order_ID) desc;

--- 20. Add up the price of all products---
Select sum(Price) as "Price of all products"
from product;

--- 21 Select orderID together with the total price of that Order, order the result by total
-- price of order in increasing order---
select o.orderid, sum(price) as "Total Price of Order"
from order_details as o
inner join product as p on o.productID = p.ProductID
group by order_id
order by sum(price);
select * from  customer;
select * from order_details;

--- 22. Select customer who spend the most money---
select c.Customerid, Customer_Name, sum(price)
from customer as c
inner join orders as o on o.Customer_id = c.Customerid
inner join order_details as od on o.order_id = od.OrderID
inner join product as p on od.ProductID = p.ProductId
group by c.customerID
order by sum(price) desc
limit 1;
select * from  customer;
select * from order_details;
select * from orders;
select * from product;

--- 23. Select customer who spend the most money and lives in Canada.
select c.Customerid, Customer_Name, sum(price), country
from customer as c
inner join orders as o  on o.Customer_id = c.Customerid
inner join order_details as od on o.order_id = od.OrderID
inner join product as p on od.ProductID = p.ProductId
where country in ("canada")
group by c.customerID
order by sum(price) desc
limit 1;

--- 24. Select customer who spend the second most money---
select c.Customerid, Customer_Name, sum(price), country
from customer as c
inner join orders as o  on o.Customer_id = c.Customerid
inner join order_details as od on o.order_id = od.OrderID
inner join product as p on od.ProductID = p.ProductId
group by c.customerID
order by sum(price) desc
limit 1,1;

--- 25. Select shipper together with the total price of proceed orders.
select Shipper_Name, sum(price) as "Total price of Proceed Orders"
from shippers as s
join orders as o on s.ShipperID = o.ShipperID
join order_details as od on o.order_ID = od.orderID
join product as p on od.productID = p.ProductID
group by s.ShipperID;

select * from shippers;