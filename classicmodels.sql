use classicmodels;
SELECT productCode, productName, productVendor, quantityInStock, MSRP, buyPrice
FROM products
WHERE buyPrice > 20 AND buyPrice < 100;

SELECT*FROM products
WHERE productName LIKE '%a%' OR productName LIKE '%A%'
   OR productVendor LIKE '%b%' OR productVendor LIKE '%B%';
   
UPDATE customers
SET customerName = 'James'
WHERE customerNumber = 106;

select o.status, sum(odt.priceEach * quantityOrdered) as total 
from orders o join orderdetails odt on o.orderNumber = odt.orderNumber group by o.status;

select sum(odt.priceEach * quantityOrdered) as total 
from orders o join orderdetails odt on o.orderNumber = odt.orderNumber where year(o.orderDate) > 2003;

select orderNumber, SUM(quantityOrdered * priceEach) AS totalAmount
from orderdetails
group by orderNumber;

SELECT p.productCode, UCASE(p.productName) as `name_product`, LCASE(p.productVendor) as `product_vendor`
FROM products p
JOIN orderdetails ordt
ON p.productCode = ordt.productCode
JOIN orders od
ON ordt.orderNumber = od.orderNumber
WHERE YEAR(od.orderDate) = 2003
GRoup by p.productCode;

select*from customers where customerName = 'Land of Toys Inc.';
explain select*from customers where customerName = 'Land of Toys Inc.';
alter table customers add index idx_customerName(customerName);
explain select*from customers where customerName = 'Land of Toys Inc.';
alter table customers add index idx_full_name(contactFirstName, contactLastName);
explain select*from customers where contactFirstName = 'Jean' or contactFirstName = 'King';
alter table customers drop index_id_full_name;

DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //
DELIMITER ;
call findAllCustomers();
DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//
CREATE PROCEDURE findAllCustomers()
BEGIN
SELECT * FROM customers where customerNumber = 175;
END //
DELIMITER ;
call findAllCustomers();

create view customer_views as
select customerNumber, customerName, phone
from customers;
select*from customer_views;

drop view customer_view;

create or replace view customer_views as
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city = 'Nantes';
select*from customer_views;

drop view customer_views;


