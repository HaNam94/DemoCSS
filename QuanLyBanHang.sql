create database QuanLyBanHang;
use QuanLyBanHang;
create table customers(
customer_number int primary key,
customer_company varchar(50) not null,
customer_last_name varchar(20) not null,
customer_first_name varchar(20) not null,
phone varchar(20) not null,
address_line1 varchar(100) not null,
address_line2 varchar(100),
city varchar(20) not null,
state varchar(20) not null,
postal_code varchar(20) not null,
country varchar(20) not null,
credit_limit double default 0.0
);

create table orders(
order_number int primary key,
order_date date not null,
required_date date not null,
shipped_date date not null,
order_status varchar(100) not null,
order_comment varchar(255) default 'N/A',
quantity_ordered int not null,
price_each double not null,
customer_number int,
foreign key(customer_number) references
customers(customer_number)
);

create table payments(
customer_number int,
check_number varchar(20) not null,
payment_date date not null,
amount double not null,
foreign key(customer_number) references
customers(customer_number)
);

create table product_lines(
product_line varchar(50) primary key,
text_description varchar(255) not null,
image varchar(255)
);

create table products(
product_code varchar(20) primary key,
product_name varchar(50) not null,
product_scale varchar(20) not null,
product_vendor varchar(50) not null,
product_description varchar(255) not null,
quantity_in_stock int not null,
buy_price double not null,
retail_price double not null,
product_line varchar(50),
foreign key(product_line) references
product_lines(product_line)
);

create table offices(
office_code varchar(20) primary key,
city varchar(20) not null,
phone varchar(20) not null,
address_line1 varchar(50) not null,
address_line2 varchar(50) default 'N/A',
state varchar(20) not null,
country varchar(20) not null,
postal_code varchar(20) not null
);

create table employees(
employee_number varchar(20) primary key,
last_name varchar(20) not null,
first_name varchar(20) not null,
email varchar(50) not null,
job_title varchar(50) not null,
report_to varchar(20),
office_code varchar(20),
foreign key(report_to) references employees(employee_number),
foreign key(office_code) references offices(office_code)
);

create table order_details(
product_code varchar(20) not null,
order_number int not null,
foreign key(product_code) references products(product_code),
foreign key(order_number) references orders(order_number)
);