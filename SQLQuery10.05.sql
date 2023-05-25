USE SoftUni

CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName, LastName
	FROM [dbo].[Employees]
	WHERE Salary > 35000
GO

EXEC usp_GetEmployeesSalaryAbove35000;

CREATE PROC usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4))
AS
SELECT FirstName, LastName
	FROM [dbo].[Employees]
	WHERE Salary >= @number

EXEC usp_GetEmployeesSalaryAboveNumber 48100;

CREATE OR ALTER PROC usp_GetTownsStartingWith (@string VARCHAR(50))
AS
SELECT [Name] 
	FROM [dbo].[Towns]
	WHERE [Name] LIKE @string + '%'

EXEC usp_GetTownsStartingWith n;

CREATE OR ALTER PROC usp_GetEmployeesFromTown (@town VARCHAR(50))
AS
SELECT e.FirstName, e.LastName 
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[Addresses] AS a ON e.AddressID = a.AddressID
	JOIN [dbo].[Towns] AS t ON a.TownID = t.TownID
	WHERE t.Name = @town

EXEC usp_GetEmployeesFromTown Sofia;

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @levelOfSalary VARCHAR(50)
	IF @salary < 30000 SET @levelOfSalary = 'Low' 
	ELSE IF @salary < 50000 SET @levelOfSalary = 'Average' 
	ELSE SET @levelOfSalary = 'High' 
	RETURN @levelOfSalary
END

SELECT [dbo].[ufn_GetSalaryLevel](20000) FROM [dbo].[Employees];

CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@levelOfSalary VARCHAR(50))
AS
SELECT FirstName, LastName
	FROM [dbo].[Employees]
	WHERE [dbo].[ufn_GetSalaryLevel](Salary) = @levelOfSalary

EXEC usp_EmployeesBySalaryLevel average;

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50)) 
RETURNS BIT
AS
BEGIN
DECLARE @currentIndex int = 1;

WHILE(@currentIndex <= LEN(@word))
	BEGIN

	DECLARE @currentLetter varchar(1) = SUBSTRING(@word, @currentIndex, 1);

	IF(CHARINDEX(@currentLetter, @setOfLetters)) = 0
	BEGIN
	RETURN 0;
	END

	SET @currentIndex += 1;
	END

RETURN 1;
END


CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	
	-- First delete all records from EmplyeesProjects 
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN ( 
					     SELECT EmployeeID FROM [dbo].[Employees]
						 WHERE DepartmentID = @departmentId
					   )

	-- Set ManagerId to NULL where Manager is an Employee
	UPDATE Employees
	SET ManagerId = NULL
	WHERE ManagerID IN ( 
					     SELECT EmployeeID FROM [dbo].[Employees]
						 WHERE DepartmentID = @departmentId
					   )

	--Alter column ManagerID in Departments table and make it NULL
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT

	--Set ManagerID to NULL where Manager is an Employees in Departments
	UPDATE Departments 
	SET ManagerID = NULL
	WHERE ManagerID IN ( 
					     SELECT EmployeeID FROM [dbo].[Employees]
						 WHERE DepartmentID = @departmentId
					   )

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @departmentId

END

EXEC usp_DeleteEmployeesFromDepartment 3

SELECT * FROM [dbo].[Accounts]
SELECT * FROM [dbo].[AccountHolders]

CREATE OR ALTER PROC usp_GetHoldersFullName 
AS 
SELECT [FirstName] + ' ' + [LastName] AS [FullName]
FROM [dbo].[AccountHolders]

EXEC usp_GetHoldersFullName;

CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@money DECIMAL(18,4))
AS
SELECT FirstName, LastName FROM (SELECT ah.Id, SUM(Balance) AS TotalBalance FROM [dbo].[AccountHolders] ah
		JOIN [dbo].[Accounts] a ON ah.Id = a.AccountHolderId
		GROUP BY ah.Id
		) AS TotalBalanceQuery
JOIN [dbo].[AccountHolders] AS ah2 ON TotalBalanceQuery.Id = ah2.Id
WHERE TotalBalance > @money
ORDER BY FirstName, LastName
			  
EXEC usp_GetHoldersWithBalanceHigherThan 500000;

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(18,4), @YIR FLOAT, @numberOfYears INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @futureValue DECIMAL(18,4);
	SET @futureValue = @sum * (POWER((1 + @YIR), @numberOfYears))

	RETURN @futureValue
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5);

CREATE OR ALTER PROC usp_CalculateFutureValueForAccount (@AccountId INT, @interestRate FLOAT)
AS
	SELECT a.Id AS [Account Id],
		   ah.FirstName AS [First Name],
		   ah.LastName AS [Last Name],
		   a.Balance,
		   dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, 5) AS [Balance in 5 years]
	FROM [dbo].[AccountHolders] AS ah
	INNER JOIN [dbo].[Accounts] AS a ON a.Id = ah.Id
	WHERE a.Id = @AccountId;

EXECUTE usp_CalculateFutureValueForAccount 1, 0.1

SELECT * FROM [dbo].[AccountHolders]

SELECT * FROM [dbo].[Accounts]



CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
RETURNS TABLE
AS
RETURN SELECT (
				SELECT SUM(Cash) AS [SumCash]
				FROM
					(
					SELECT g.Name,
						   ug.Cash,
						   ROW_NUMBER() OVER (PARTITION BY g.Name ORDER BY ug.Cash DESC) AS [RowNum]
					FROM Games AS g
					INNER JOIN UsersGames AS ug
					ON g.Id = ug.GameId
					WHERE g.Name = @gameName
					) AS [RowNumberQuery]
			WHERE [RowNum] % 2 <> 0
			  ) AS [SumCash]

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist');

