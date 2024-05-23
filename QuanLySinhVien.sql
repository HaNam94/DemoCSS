create database QuanLySinhVien;
use QuanLySinhVien;
create table Class(
ClassID int not null auto_increment primary key,
ClassName varchar(60) not null,
StartDate datetime not null,
Status bit
);

create table Student(
StudentId int not null auto_increment primary key,
StudentName varchar(30) not null,
Address varchar(50),
Phone varchar(20),
Status BIT,
ClassId int not null,
foreign key (ClassId) references class (ClassID)
);

create table Subject(
SubId int not null auto_increment primary key,
SubName varchar(30) not null,
Credit tinyint not null default 1 check (Credit >= 1),
Status bit default 1
);

create table Mark(
MarkId int not null auto_increment primary key,
SubId int not null,
StudentId int not null,
Mark float default 0 check (Mark between 0 and 100),
ExamTimes tinyint default 1,
unique (SubId, StudentId),
foreign key (SubId) references Subject (SubId),
foreign key (StudentId) references Student (StudentId)
);

select*from class;
select*from Student;
select*from Subject;
select*from Mark;

insert into Class
values (1, 'A1', '2008-12-20', 1);
insert into Class
values (2, 'A2', '2008-12-22', 1);
insert into Class
values (3, 'B3', current_date, 0);

insert into Student (StudentName, Address, Phone, Status, ClassId)
values ('Nhat', 'Ha Noi', '0914113113', 1, 1);
insert into Student (StudentName, Address, Status, ClassId)
values ('Quang', 'Bac Ninh', 1, 1);
insert into Student (StudentName, Address, Phone, Status, ClassId)
values ('Hai', 'HCM', '0912321321', 0, 2);

insert into Subject
values (1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,1,8,1),
(1,2,10,2),
(2,1,12,1);

select*from Student
where Status = true;

select*from Subject
where Credit < 10;

select S.StudentId, S.StudentName, C.ClassName
from Student S join Class C on S.ClassId = C.ClassID;
select S.StudentId, S.StudentName, C.ClassName
from Student S join Class C on S.ClassId = C.ClassID
where C.ClassName = 'A1';
select S.StudentId, S.StudentName, Sub.SubName, M.Mark
from Student S 
join Mark M on S.StudentId = M.StudentId
join Subject sub on M.Subid = Sub.SubId
where Sub.SubName = 'CF';
update Student set ClassId = 2
where StudentName = 'Hung';
SET SQL_SAFE_UPDATES = 0;

select*from Student 
where StudentName like 'H';
select*from Class
where month(StartDate) = 12;
select*from Subject
where Credit between 3 and 5;
select S.StudentName, Sub.SubName, M.Mark
from Student S
join Mark M on S.StudentId = M.StudentId
join Subject Sub on M.SubId = Sub.SubId
order by M.Mark desc, S.StudentName asc;

select Address, count(StudentId) as 'Số lượng học viên'
from Student
group by Address;

select S.StudentId, S.StudentName, avg(Mark)
from Student S join Mark M on S.StudentId = M.StudentId
group by S.StudentId, S.StudentName
having avg(Mark) >= all(select avg(Mark) from Mark group by Mark.StudentId);

SELECT*FROM Subject
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

SELECT Sub.SubId, Sub.SubName, MAX(Mark) AS Max_Mark
FROM Subject Sub
JOIN Mark M ON Sub.SubId = M.SubId
GROUP BY Sub.SubId, Sub.SubName;

SELECT S.StudentId, S.StudentName, AVG(M.Mark) AS Avg_Mark
FROM Student S
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
ORDER BY Avg_Mark DESC;