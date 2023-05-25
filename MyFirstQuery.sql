CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions (
Id INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
Age TINYINT
)

CREATE TABLE Towns (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)

INSERT INTO Towns(Id, [Name])
	VALUES 
			(1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Stara Zagora'),
			(4, 'Varna'),
			(5, 'Ruse')

SELECT * FROM Towns

INSERT INTO Minions(Id, [Name], Age, TownId)
	VALUES
			(1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Steward', NULL, 2)

SELECT * FROM Minions

SELECT * FROM Towns

TRUNCATE TABLE Minions
SELECT * FROM Minions

DROP TABLE Minions
DROP TABLE Towns

CREATE TABLE Users(
	Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX)
	CHECK(DATALENGTH(ProfilePicture) <= 900 * 1024),
	LastLoginTime DATETIME2 NOT NULL,
	IsDeleted BIT NOT NULL
)

INSERT INTO Users(Username, [Password], LastLoginTime, isDeleted)
VALUES
('Pesho0', '123456', '02.27.2023', 0),
('Pesho1', '123456', '02.27.2023', 1),
('Pesho2', '123456', '02.27.2023', 0),
('Pesho3', '123456', '02.27.2023', 0),
('Pesho4', '123456', '02.27.2023', 0)

SELECT * FROM Users

DELETE FROM Users
WHERE Id = 5

INSERT INTO Users(Username, [Password], LastLoginTime, isDeleted)
VALUES
('Pesho5', '123456', '02.27.2023', 0)

ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC079A0C3391]


ALTER TABLE Users
ADD CONSTRAINT PK_Users_CompositeIdUsername
PRIMARY KEY(Id, Username)

ALTER TABLE Users
ADD CONSTRAINT CK_Users_PasswordLength
CHECK(LEN([Password]) >= 5)


INSERT INTO Users(Username, [Password], LastLoginTime, isDeleted)
VALUES
('Pesho555', '12377777', '02.27.2023', 0)

ALTER TABLE Users
ADD CONSTRAINT DF_Users_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users(Username, [Password], isDeleted)
VALUES
('Pesho777', '12377777', 0)


CREATE TABLE Departments (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MidlleName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments NOT NULL,
	HireDate DATE NOT NULL,
	Salary DECIMAL(7, 2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id) 
)

INSERT INTO Towns([Name])
	VALUES
		   ('Sofia'), 
		   ('Plovdiv'), 
		   ('Varna'), 
		   ('Burgas')

INSERT INTO Departments([Name])
	VALUES
			('Engineering'), 
			('Sales'), 
			('Marketing'), 
			('Software Developmen'),
			('Quality Assurance')

INSERT INTO Employees(FirstName, MidlleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
	VALUES
			('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4,  '02/01/2013', '3500.00'),
			('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1,  '03/02/2004', '4000.00'),
			('Maria', 'Petrova', 'Ivanova', 'Intern', 5,  '08/28/2016', '525.25'),
			('Georgi', 'Terziev', 'Ivanov', 'CEO', 2,  '12/09/2007', '3000.00'),
			('Peter', 'Pan', 'Pan', 'Intern', 3,  '08/28/2016', '599.88')

	USE SoftUni

	SELECT [Name] FROM Towns
	ORDER BY [Name] 

	SELECT [Name] FROM Departments
	ORDER BY [Name] 

	SELECT FirstName, LastName, JobTitle, Salary FROM Employees
	ORDER BY [Name] ASC	

	UPDATE Employees
	SET Salary += Salary * 0.1

	SELECT Salary FROM Employees

	USE SoftUni

	CREATE TABLE FirstOrders (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	NameOrders VARCHAR(30) NOT NULL
	)

	USE Minions

	CREATE TABLE Minions (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age TINYINT
	)

	CREATE TABLE Towns (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	)

	DROP TABLE Minions
	DROP TABLE Towns

	ALTER TABLE Minions 
	ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)

	INSERT INTO Minions (Id, [Name], Age, TownId)
		VALUES
				(1,'Kevin', 22, 1),
				(2,'Bob', 15, 3),
				(3,'Steward', NULL, 2)
	
	INSERT INTO Towns (Id, [Name])
		VALUES
				(1, 'Sofia'),
				(2, 'Plovdiv'),
				(3, 'Varna')

 
	TRUNCATE TABLE Minions
	SELECT * FROM Minions

	CREATE DATABASE Hotel

	USE Hotel

	CREATE TABLE Employees(
		Id INT PRIMARY KEY IDENTITY NOT NULL,
		FirstName NVARCHAR(50) NOT NULL,
		LastName NVARCHAR(50) NOT NULL,
		Title NVARCHAR(30) NOT NULL,
		Notes NVARCHAR(100)
	) 

	 CREATE TABLE Customers(
		AccountNumber INT PRIMARY KEY NOT NULL,
		FirstName NVARCHAR(50) NOT NULL,
		LastName NVARCHAR(50) NOT NULL,
		PhoneNumber BIGINT NOT NULL,
		EmergencyName NVARCHAR(50) NOT NULL,
		EmergencyNumber BIGINT NOT NULL,
		Notes NVARCHAR(100),
		CHECK (PhoneNumber > 0)
	) 
	
	 CREATE TABLE RoomStatus(
		RoomStatus NVARCHAR(20) PRIMARY KEY NOT NULL,
		Notes NVARCHAR(100)
	) 

	 CREATE TABLE RoomTypes(
		RoomTypes NVARCHAR(20) PRIMARY KEY NOT NULL,
		Notes NVARCHAR(100)
	) 
	
	 CREATE TABLE BedTypes(
		BedTypes NVARCHAR(20) PRIMARY KEY NOT NULL,
		Notes NVARCHAR(100)
	) 

	CREATE TABLE Rooms(
		RoomNumber INT PRIMARY KEY IDENTITY NOT NULL,
		RoomType NVARCHAR(20) NOT NULL,
		BedType NVARCHAR(20) NOT NULL,
		Rate TINYINT NOT NULL,
		RoomStatus NVARCHAR(20) NOT NULL,
		Notes NVARCHAR(100),
		CHECK (Rate >= 0)
	) 

	CREATE TABLE Payments(
		Id INT PRIMARY KEY IDENTITY NOT NULL,
		EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
		PaymentDate DATE NOT NULL,
		AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
		FirstDateOccupied DATE NOT NULL,
		LastDateOccupied DATE NOT NULL,
		TotalDays INT NOT NULL,
		AmountCharged INT NOT NULL,
		TaxRate INT NOT NULL,
		TaxAmount INT NOT NULL,
		PaymentTotal INT NOT NULL,
		Notes NVARCHAR(100)
	) 
	
	CREATE TABLE Occupancies(
		Id INT PRIMARY KEY IDENTITY NOT NULL,
		EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
		DateOccupied DATE NOT NULL,
		AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
		RoomNumber INT NOT NULL,
		RateApplied INT NOT NULL,
		PhoneCharge INT NOT NULL,
		Notes NVARCHAR(100),
		CHECK (PhoneCharge >= 0)
	) 

	INSERT INTO Employees(FirstName, LastName, Title, Notes)
			VALUES
					('Hristo', 'Stoichkov', 'Forward', 'The best'),
					('Leo', 'Messi', 'Playmaker', 'GOAT'),
					('Cristiano', 'Ronaldo', 'Winger', 'best')


	INSERT INTO Customers(AccountNumber,FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
	(1, 'Boyko','Boykov', 49123456789, 'Barroso', 32987654321),
	(2, 'Maraya','Cary', 1123456789, 'Mara', 458),
	(3, 'Tom','Jones', 41987654321, 'Tomy', 567567567657)


INSERT INTO RoomStatus(RoomStatus)
			VALUES
					('Reserve'),
					('Occup'),
					('Avail')

INSERT INTO RoomTypes(RoomTypes)
			VALUES
					('SingleRoom'),
					('DoubleRoom'),
					('ApartmentRoom')

INSERT INTO BedTypes(BedTypes)
			VALUES
					('SingleBed'),
					('TwinBed'),
					('DoubleBed')

INSERT INTO Rooms(RoomType, BedType, Rate, RoomStatus)
			VALUES
					('Single','Single', 75,'Available'),
					('Double','Double', 90, 'Occupied'),
					('Apartment','Twin', 80, 'Reserved')


INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal)
	VALUES 
	(1, '2017-01-22', 1, '2017-01-21', '2017-01-22', 1, 100, 0.20, 20, 120),
	(1, '2017-01-22', 2, '2017-01-20', '2017-01-22', 2, 200, 0.20, 40, 240),
	(1, '2017-01-22', 3, '2017-01-19', '2017-01-22', 3, 300, 0.20, 60, 360)														

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
	VALUES 
	(1, '2017-01-22', 1, 25, 90, 0),
	(2, '2017-01-22', 2, 35, 80, 0),
	(3, '2017-01-22', 3, 45, 70, 10)	

UPDATE Payments
	SET TaxRate = TaxRate * 0.97

	SELECT TaxRate FROM Payments