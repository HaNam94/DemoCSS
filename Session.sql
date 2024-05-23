create database session;
use session;

create table products(
	id int,
    product_code varchar(20) not null,
    product_name varchar(20) not null,
    product_price int not null,
    product_amount int not null,
    product_description varchar(255) not null default 'N/A',
    product_status varchar(20) not null default 'Available',
    primary key(id)
);    

insert into products(id, product_code, product_name, product_price, product_amount) values
	(1, 'P-001', 'Iphone 8S', 12000, 4),
	(2, 'P-002', 'Iphone 5S', 11000, 2),
	(3, 'P-003', 'Samsung Galaxy', 9000, 5),
	(4, 'P-004', 'Sony Erisson', 7500, 7),
	(5, 'P-005', 'Black Berry', 2000, 11),
	(6, 'P-006', 'Huwei X2', 1200, 8),
	(7, 'P-007', 'Nokia K3', 1000, 1),
	(8, 'P-008', 'LG Xp4', 7000, 4),
	(9, 'P-009', 'BPhone VN', 3000, 6),
	(10, 'P-010', 'Iphone Plus', 15000, 9) ;
    
    --  Create Unique Index
create index idx_code 
on products(product_code);

-- create complex index
create index idx_name_price
on products(product_name, product_price);

-- using 'EXPLAIN'
explain select *
from products
where product_code = 'P-005';

explain select *
from products
where product_name = 'BPhone VN';

explain select *
from products
where product_price = 7000;

explain select *
from products
where product_amount = 5;

--  Create view selecting: product_code, product_name, product_price,
--    product_status from table 'products'
create view product_info
as
	select product_code, product_name, product_price, product_status
    from products;
 
 -- call view
 select *
 from product_info;
 
 -- update view
 create or replace view product_info
 as
	select product_code, product_name, product_price
    from products;

-- call view again
select *
from product_info;

-- update view with 'alter'
update product_info
set product_price = 20000
where product_code = 'P-001';

-- call view again
select *
from product_info;

-- check table 'product'
select *
from products;

-- drop view
drop view product_info;

--  Stored Procedure

-- 1 get product infomation
delimiter $$
create procedure getProductInfo()
begin
	select *
    from products;
end; $$
delimiter ;

-- call procedure
call getProductInfo();

-- 2 add new product
delimiter $$
create procedure addNewProduct
	(in p_id int, in p_code varchar(20), 
	in p_name varchar(20), in p_price int , in p_amount int)
begin
	insert into products(id, product_code, product_name, product_price, product_amount) values
		(p_id, p_code, p_name, p_price, p_amount);
end; $$
delimiter ;

-- test procedure
call addNewProduct(11, 'P-011', 'Product-X', 55555, 100);

select *
from products;

-- 3 update a product
delimiter $$
create procedure updateProduct(in p_id int, in p_code varchar(20), 
	in p_name varchar(20), in p_price int , in p_amount int)
begin
	update products
    set product_code = p_code,
		product_name = p_name,
		product_price = p_price,
		product_amount = p_amount
	where id = p_id;
end; $$
delimiter ;

-- test procedure
call updateProduct(1, 'P-code', 'P-name', 11111, 333);

select *
from products;

-- drop procedure
drop procedure `updateProduct`;

-- 4 delete a product
delimiter $$
create procedure deleteProduct(in p_id int)
begin
	delete from products
    where id = p_id;
end; $$
delimiter ;

-- test procedure
call deleteProduct(11);

select *
from products;