CREATE DATABASE exercise;
USE exercise;

CREATE TABLE STUDENT_SCORES (
    StudentID VARCHAR(10) PRIMARY KEY,
    Mathematics DECIMAL(5,2),
    Physics DECIMAL(5,2),
    Chemistry DECIMAL(5,2),
    Literature DECIMAL(5,2),
    Classification VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES STUDENT_LIST(StudentID)
);

CREATE TABLE CLASS (
    ClassName VARCHAR(50) PRIMARY KEY,
    ClassTeacher VARCHAR(50)
);

CREATE TABLE STUDENT_LIST (
    StudentID VARCHAR(10) PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    ClassName VARCHAR(50),
    Note VARCHAR(100),
    FOREIGN KEY (ClassName) REFERENCES CLASS(ClassName)
);

INSERT INTO STUDENT_LIST (StudentID, LastName, FirstName, Gender, DateOfBirth, ClassName, Note) VALUES
('S001', 'Nguyen', 'An', 'Male', '2005-03-15', 'C02', 'Excellent student'),
('S002', 'Tran', 'Bao', 'Male', '2005-06-20', 'C02', 'Good student'),
('S003', 'Le', 'Chi', 'Female', '2005-01-10', 'C09', 'Active participant in class'),
('S004', 'Pham', 'Dung', 'Female', '2005-09-02', 'C09', NULL),
('S005', 'Hoang', 'Dat', 'Male', '2005-12-25', 'C07', 'Needs improvement in lab work'),
('S006', 'Do', 'Duc', 'Male', '2005-07-30', 'C07', NULL),
('S007', 'Vo', 'Giang', 'Female', '2005-04-18', 'C01', NULL),
('S008', 'Dang', 'Hai', 'Male', '2005-10-12', 'C01', 'Has a talent for writing'),
('S009', 'Mai', 'Hoa', 'Female', '2005-02-08', 'C02', NULL),
('S010', 'Bui', 'Khoa', 'Male', '2005-08-05', 'C09', 'Enjoys conducting experiments');

INSERT INTO STUDENT_SCORES (StudentID, Mathematics, Physics, Chemistry, Literature, Classification) VALUES
('S001', 8.5, 8.0, 8.2, 8.0, 'Excellent'),
('S002', 7.2, 7.7, 8.0, 8.0, 'Good'),
('S003', 7.5, 8.5, 7.0, 7.0, 'Good'),
('S004', 6.0, 6.5, 6.0, 6.5, 'Decent'),
('S005', 7.0, 7.5, 7.0, 7.7, 'Decent'),
('S006', 8.5, 8.5, 8.0, 6.5, 'Good'),
('S007', 9.0, 9.5, 8.5, 8.0, 'Excellent'),
('S008', 6.5, 6.0, 7.0, 9.5, 'Decent'),
('S009', 7.0, 7.5, 7.5, 7.5, 'Decent'),
('S010', 8.5, 8.5, 9.0, 10.0, 'Excellent');

INSERT INTO CLASS (ClassName, ClassTeacher) VALUES
('C02', 'Mr. Luân'),
('C07', 'Mrs. Kiều Anh'),
('C09', 'Mr. Như Anh'),
('C01', 'Ms. Long');
 
select*from STUDENT_SCORES;
select*from STUDENT_LIST;
select*from CLASS;

-- (1) --
SELECT StudentID, CONCAT(LastName, FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST;

-- (2) --
SELECT StudentID, CONCAT(LastName, FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST
WHERE DAY(DateOfBirth) = 20;

-- (3) --
SELECT StudentID, CONCAT(LastName, FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST
WHERE DateOfBirth = '1999-09-06';

-- (4) --
SELECT StudentID, CONCAT(LastName,  FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST
WHERE LastName = 'NA' OR FirstName = 'NA';

-- (5) --
SELECT StudentID, CONCAT(LastName, FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST
WHERE LastName LIKE 'N%' OR FirstName LIKE 'N%';

-- (6) --
SELECT StudentID, CONCAT(LastName, FirstName) AS FullName, DateOfBirth
FROM STUDENT_LIST
WHERE LastName LIKE '%NA%' OR FirstName LIKE '%NA%';

-- (7) --
SELECT COUNT(*)
FROM STUDENT_LIST
WHERE LastName LIKE 'N%' OR FirstName LIKE 'N%';

-- (8) --
SELECT 
    CONCAT(SL.LastName, ' ', SL.FirstName) AS FullName,
    SL.DateOfBirth,
    SL.ClassName,
    C.ClassTeacher
FROM 
    STUDENT_LIST SL
JOIN 
    CLASS C ON SL.ClassName = C.ClassName;

-- (9) --
SELECT CONCAT(LastName, FirstName) AS FullName, DateOfBirth, ROUND((Mathematics + Physics + Chemistry + Literature) / 4, 2) AS AverageScore, Classification
FROM STUDENT_LIST
JOIN STUDENT_SCORES ON STUDENT_LIST.StudentID = STUDENT_SCORES.StudentID;

-- (10) --
SELECT ClassName, COUNT(*) AS NumberOfStudents
FROM STUDENT_LIST
GROUP BY ClassName;

-- (11) --
SELECT ClassName
FROM STUDENT_LIST
GROUP BY ClassName
HAVING COUNT(*) > 5;

-- (12) --
SELECT ClassName, COUNT(*) AS StudentCount
FROM STUDENT_LIST
GROUP BY ClassName
ORDER BY StudentCount DESC
LIMIT 1;

-- (13) --
SELECT StudentID, LastName, FirstName
FROM STUDENT_SCORES
JOIN STUDENT_LIST USING(StudentID)
ORDER BY (Mathematics + Physics + Chemistry + Literature) / 4 DESC
LIMIT 1;

-- (14) --
SELECT sl.StudentID, sl.LastName, sl.FirstName
FROM STUDENT_SCORES ss
JOIN STUDENT_LIST sl ON ss.StudentID = sl.StudentID
WHERE (ss.Mathematics + ss.Physics + ss.Chemistry + ss.Literature) / 4 > 8;

-- (15) --
SELECT SUM(Mathematics + Physics + Chemistry + Literature) AS TotalScore
FROM STUDENT_SCORES ss
JOIN STUDENT_LIST sl ON ss.StudentID = sl.StudentID
WHERE sl.FirstName LIKE 'NA%';

-- (16) --
SELECT sl.StudentID, sl.LastName, sl.FirstName
FROM STUDENT_SCORES ss
JOIN STUDENT_LIST sl ON ss.StudentID = sl.StudentID
WHERE (ss.Mathematics + ss.Physics + ss.Chemistry + ss.Literature) / 4 > 5
AND ss.Mathematics > 8;

-- (17) --
SELECT sl.StudentID, sl.LastName, sl.FirstName
FROM STUDENT_SCORES ss
JOIN STUDENT_LIST sl ON ss.StudentID = sl.StudentID
WHERE ss.Classification = 'Excellent';

-- (18) --
SELECT COUNT(*)
FROM STUDENT_SCORES
WHERE Classification = 'Excellent';

-- (19) --
SELECT sl.ClassName, COUNT(*)
FROM STUDENT_SCORES ss
JOIN STUDENT_LIST sl ON ss.StudentID = sl.StudentID
WHERE ss.Classification = 'Excellent'
GROUP BY sl.ClassName;

-- (20) --
SELECT StudentID, LastName, FirstName
FROM STUDENT_LIST
WHERE Note IS NULL;

-- (21) --
SELECT 
    s.ClassName,
    s.StudentID,
    s.LastName,
    s.FirstName,
    ROUND((sc.Mathematics + sc.Physics + sc.Chemistry + sc.Literature) / 4, 2) AS AverageScore
FROM 
    STUDENT_LIST s
JOIN 
    STUDENT_SCORES sc ON s.StudentID = sc.StudentID
WHERE 
    (sc.Mathematics + sc.Physics + sc.Chemistry + sc.Literature) / 4 = (
        SELECT 
            MAX((sc2.Mathematics + sc2.Physics + sc2.Chemistry + sc2.Literature) / 4)
        FROM 
            STUDENT_LIST s2
        JOIN 
            STUDENT_SCORES sc2 ON s2.StudentID = sc2.StudentID
        WHERE 
            s2.ClassName = s.ClassName
    )
ORDER BY 
    s.ClassName;