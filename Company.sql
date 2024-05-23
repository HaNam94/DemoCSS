create database company;
use company;

create table employees(
id int auto_increment primary key,
name varchar(50) not null,
deparment varchar(50) not null,
salary decimal(10,2) not null
);

delimiter //
create trigger update_department
before insert on employees
for each row
begin
	if NEW.salary >= 5000 then
		set new.deparment = 'Management';
    elseif NEW.salary >= 3000 then
		set new.deparment = 'Sales';
	else
		set new.deparment = 'Support';
	end if;
end //
delimiter ;

insert into employees (name, deparment, salary)
values ('John Smith', 'A', 3500),
		('Jane Jackson', 'A', 2000),
        ('David Beckham', 'A', 6000);