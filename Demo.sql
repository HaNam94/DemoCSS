create database demo;
use demo;
create table Student(
id int,
name varchar(200),
age int,
country varchar(50)
);

insert into Student(id, name, age, country) values
(1, 'Nam', 30, 'HN'),
(2, 'Trung', 26, 'HN'),
(3, 'Quang', 29, 'BN'),
(4, 'Hoang', 20, 'PT');

select*from Student;
update Student set country = 'BG' where name = 'Nam';
update Student set country = 'BG' where age = 30;
update Student set country = 'BG' where id = 1;
SET SQL_SAFE_UPDATES = 0;

create table user(
id int primary key auto_increment,
name varchar(50) not null,
email varchar(50) not null unique,
password varchar(50) not null,
role varchar(50) default 1
);