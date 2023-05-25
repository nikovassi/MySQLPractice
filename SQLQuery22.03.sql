CREATE DATABASE Practice

USE Practice

CREATE TABLE Manufacturers (
ManufacturerID INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL)

CREATE TABLE Models(
ModelID INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
ManufacturerID INT NOT NULL REFERENCES Manufacturers(ManufacturerID))

INSERT INTO Manufacturers(ManufacturerID, [Name], EstablishedOn)
	VALUES 
		   (1, 'BMW', '07/03/1916'),
		   (2, 'Tesla', '01/01/2003'),
		   (3, 'Lada', '05/01/1966')

INSERT INTO Models(ModelID, [Name], ManufacturerID)
	VALUES 
		   (101, 'X1', 1),
		   (102, 'i6', 1),
		   (103, 'Model S', 2),
		   (104, 'Model X', 2),
		   (105, 'Model 3', 2),
		   (106, 'Nova', 3)

SELECT * FROM Models
SELECT * FROM Manufacturers

--

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE Exams(
ExamID INT PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE StudentsExams(
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
PRIMARY KEY (StudentID, ExamID))


INSERT INTO Students(StudentID, [Name])
	VALUES
		  (1, 'Mila'),
		  (2, 'Toni'),
		  (3, 'Ron')

INSERT INTO Exams(ExamID, [Name])
	VALUES
		  (101, 'SpringMVC'),
		  (102, 'Neo4j'),
		  (103, 'Oracle 11g')


INSERT INTO StudentsExams(StudentID, ExamID)
	VALUES
		  (1, 101),
		  (1, 102),
		  (2, 101),
		  (3, 103),
		  (2, 102),
		  (2, 103)

SELECT * FROM Students

DROP TABLE Students
DROP TABLE Exams
DROP TABLE StudentsExams

SELECT * FROM Exams

SELECT * FROM StudentsExams

SELECT s.[Name], e.[Name] FROM StudentsExams AS se
JOIN Students AS s ON se.StudentID = s.StudentID
JOIN Exams AS e ON se.ExamID = e.ExamID


CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID));

INSERT INTO Teachers (TeacherID, [Name], ManagerID)
	VALUES 
			(101, 'John', NULL),
			(102, 'Maya', 106),
			(103, 'Silvia', 106),
			(104, 'Ted', 105),
			(105, 'Mark', 101),
			(106, 'Greta', 101)

SELECT * FROM Teachers

