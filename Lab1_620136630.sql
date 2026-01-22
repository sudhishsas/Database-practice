DROP DATABASE uwi;
CREATE DATABASE uwi;

USE uwi;

CREATE TABLE `student` (
    `StudentID` INT(6) NOT NULL,
    `Name` VARCHAR(255) NOT NULL ,
    `Address` VARCHAR(255) NOT NULL ,
    `Email` VARCHAR(50) NOT NULL ,
    PRIMARY KEY  (`StudentID`)
);

INSERT INTO `student` ( StudentID, Name, Address, Email) VALUES 
(62008,'John Roberts', '10 Holloway Drive', 'jonrrobert@uwi.com'),
(63009, 'Sally Banner', '5 Main Street', 'sbanner@uwi.com'),
(64015, 'Bruce Stark', '2 Downing Street', 'bstark@uwi.com'),
(72001, 'Dianna Banner', '2 Pepsi Ave', 'dbanner@uwi.com'),
(62909, 'Damon Stark', '1 Dragon Lane', 'dstark@ironthrone.com'),
(70012, 'Arya Lannister', '2 Hightower Ave', 'alannisterr@starky.com'),
(40055, 'John Lee', '3 Pepsi Ave', 'jlee@hotmail.com');

SELECT * FROM student;

CREATE TABLE `course` (
    `CourseID` VARCHAR(8) NOT NULL,
    `CourseName` VARCHAR(255) NOT NULL ,
    `DateCreated` DATE NOT NULL ,
    PRIMARY KEY  (`CourseID`)
);

INSERT INTO `course` ( CourseID, CourseName, DateCreated) VALUES
('COMP1178', 'Introduction to Python', DATE('2009-10-12')),
('BIO8727', 'Exoskeleton', DATE('2010-11-12')),
('PHYS1190', 'Quantum Physics', DATE('2009-10-11')),
('COMP1190', 'Introduction to C', DATE('2010-11-01')),
('COMP1200', 'Introduction to Java', DATE('2012-11-12')),
('ECON8000', 'Introduction to Statistics', DATE('2015-10-12')); 

SELECT * FROM course;

CREATE TABLE `enrol`(`Grade` INT(3)) SELECT student.StudentID, course.CourseID
		FROM `student`, `course` ;        
UPDATE `enrol` SET `Grade`= 89 WHERE StudentID = 62008 AND CourseID = 'PHYS1190';
UPDATE `enrol` SET `Grade`= 69 WHERE StudentID = 72001 AND CourseID = 'PHYS1190';
UPDATE `enrol` SET `Grade`= 78 WHERE StudentID = 62909 AND CourseID = 'ECON8000'; 
UPDATE `enrol` SET `Grade`= 91 WHERE StudentID = 72001 AND CourseID = 'ECON8000';
UPDATE `enrol` SET `Grade`= 67 WHERE StudentID = 64015 AND CourseID = 'ECON8000';
UPDATE `enrol` SET `Grade`= 45 WHERE StudentID = 62008 AND CourseID = 'ECON8000';
UPDATE `enrol` SET `Grade`= 48 WHERE StudentID = 40055 AND CourseID = 'COMP1200'; 
UPDATE `enrol` SET `Grade`= 78 WHERE StudentID = 62008 AND CourseID = 'COMP1200';
UPDATE `enrol` SET `Grade`= 67 WHERE StudentID = 63009 AND CourseID = 'COMP1200';
UPDATE `enrol` SET `Grade`= 90 WHERE StudentID = 70012 AND CourseID = 'COMP1200';
UPDATE `enrol` SET `Grade`= 70 WHERE StudentID = 72001 AND CourseID = 'COMP1200'; 
UPDATE `enrol` SET `Grade`= 56 WHERE StudentID = 62008 AND CourseID = 'BIO8727'; 
UPDATE `enrol` SET `Grade`= 85 WHERE StudentID = 62008 AND CourseID = 'COMP1178';
UPDATE `enrol` SET `Grade`= 45 WHERE StudentID = 62909 AND CourseID = 'COMP1178';
UPDATE `enrol` SET `Grade`= 75 WHERE StudentID = 63009 AND CourseID = 'COMP1190';
UPDATE `enrol` SET `Grade`= 66 WHERE StudentID = 62008 AND CourseID = 'COMP1190';
UPDATE `enrol` SET `Grade`= 75 WHERE StudentID = 63009 AND CourseID = 'COMP1190';
DELETE FROM `enrol` WHERE Grade IS NULL;

SELECT * FROM `enrol`;	
#a 			
SELECT `CourseName` From `course`;
#b
SELECT `Name`, `Address` FROM `student`;
#c
SELECT `Address` FROM `student` WHERE Name = 'John Roberts';
#d
SELECT `Name` FROM `student` WHERE Address like '%Pepsi Ave%';
#e
SELECT `CourseName` FROM `course` WHERE DateCreated BETWEEN '2009-01-01 00:00:00' AND '2010-12-30 00:00:00';
#f
SELECT `CourseID` FROM `course` WHERE CourseName = 'Quantum Physics';
#g
SELECT student.Name, enrol.CourseID FROM `student` JOIN `enrol` ON enrol.courseID = 'COMP1200' AND enrol.StudentID = student.StudentID;
#h
SELECT student.Name, enrol.Grade FROM `student` JOIN `enrol` ON enrol.CourseID = 'ECON8000' AND student.StudentID=enrol.StudentID ORDER BY Grade DESC limit 0,1;
#i
SELECT enrol.CourseID, count(*) as count FROM `enrol` GROUP BY CourseID ORDER BY count DESC LIMIT 1;
#j
SELECT enrol.CourseID, count(*) as count FROM `enrol` GROUP BY CourseID ORDER BY count ASC LIMIT 1;
#k
SELECT enrol.CourseID FROM `enrol` WHERE Grade IN(SELECT MAX(Grade) FROM `enrol`);
#l
CREATE VIEW avgGrade AS SELECT  enrol.StudentID, AVG(Grade) as average FROM `enrol` GROUP BY enrol.StudentID ORDER BY average;
SELECT student.Name, average FROM `student` JOIN `avgGrade` ON student.StudentID = avgGrade.StudentID order BY average DESC LIMIT 1;
#m 
SELECT student.Name, average FROM `student` JOIN `avgGrade` ON student.StudentID = avgGrade.StudentID AND student.Name='John Roberts';
#n
CREATE VIEW encourses AS SELECT enrol.StudentID, count(CourseID) AS numencourses FROM `enrol` GROUP BY enrol.StudentID;
SELECT student.Name, encourses.numencourses FROM `student` JOIN `encourses` ON student.StudentID = encourses.StudentID ORDER BY numencourses DESC LIMIT 1;