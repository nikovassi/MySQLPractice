USE SoftUni

SELECT [FirstName], [LastName] 
	FROM [dbo].[Employees]
	WHERE [FirstName] LIKE 'sa%';

SELECT [FirstName], [LastName] 
	FROM [dbo].[Employees]
	WHERE LastName LIKE '%EI%';

SELECT * FROM [dbo].[Employees]


SELECT  FirstName FROM [dbo].[Employees]
WHERE DepartmentId IN (3,10) AND 
DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

SELECT  FirstName, LastName FROM [dbo].[Employees]
WHERE JobTitle NOT LIKE '%engineer%';

SELECT [Name] FROM [dbo].[Towns]
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name];

SELECT * FROM [dbo].[Towns]
WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name];

SELECT TownID, [Name] FROM [dbo].[Towns]
WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name] ASC;

SELECT * FROM Employees

CREATE VIEW [V_EmployeesHiredAfter2000] AS
SELECT FirstName, LastName
	FROM Employees
	WHERE DATEPART(YEAR, HireDate) > 2000;

SELECT FirstName, LastName
	FROM Employees
	WHERE LEN(LastName) = 5;

SELECT EmployeeID, FirstName, LastName, Salary, 
	DENSE_RANK() OVER(PARTITION BY Salary
                 ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000 
	ORDER BY Salary DESC

SELECT * FROM (SELECT EmployeeID, FirstName, LastName, Salary, 
	DENSE_RANK() OVER(PARTITION BY Salary
                 ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000) AS [RankTable]
	WHERE [Rank] = 2
	ORDER BY Salary DESC

USE [Geography]

SELECT CountryName, IsoCode 
	FROM Countries
	WHERE CountryName LIKE '%a%a%a%'
	ORDER BY IsoCode;

SELECT * FROM Peaks
SELECT * FROM Rivers

SELECT p.PeakName, r.RiverName, LOWER(
CONCAT(p.PeakName, SUBSTRING(r.RiverName, 2, LEN(r.RiverName) - 1))) AS [Mix]
FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName, 1)
ORDER BY Mix

USE [Diablo]

SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start] 
	FROM Games
		WHERE DATEPART(YEAR,[Start]) IN (2011,2012)
		ORDER BY [Start] , [Name]

SELECT Username, 
	RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS Email 
	FROM Users
	ORDER BY [Email], Username

	SELECT Username, IpAddress FROM [dbo].[Users]
	WHERE IpAddress LIKE '___.1%.%.___'
	ORDER BY Username;

SELECT * FROM [dbo].[Games]
	
SELECT [Name],
	CASE 
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS [Part of the day],
	CASE 
		WHEN [Duration] <= 3 THEN 'Extra Short'
		WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
		WHEN [Duration] > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
	FROM Games
	ORDER BY [Name], Duration, [Part of the day]

	USE [Orders]

	SELECT * FROM [dbo].[Orders]

SELECT ProductName, [OrderDate],
DATEADD(DAY,3, [OrderDate]) AS PayDate, 
DATEADD(MONTH,1, [OrderDate]) AS [Deliver Due]
FROM [dbo].[Orders];

CREATE TABLE People (
Id INT PRIMARY KEY NOT NULL, 
[Name] NVARCHAR(50) NOT NULL, 
Birthdate DATETIME2 NOT NULL)

INSERT INTO People(Id, [Name],Birthdate)
	VALUES
			(1, 'Victor', '2000-12-07 00:00:00.000'),
			(2, 'Steven', '1992-09-10 00:00:00.000'),
			(3, 'Stephen', '1910-09-19 00:00:00.000'),
			(4, 'John', '2010-01-06 00:00:00.000')

	     
SELECT [Name], Birthdate,
	   DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
       DATEDIFF(MONTH, Birthdate, DATEADD(YEAR, DATEDIFF(YEAR, Birthdate, GETDATE()), Birthdate)) AS [Age in Months],
       DATEDIFF(DAY, Birthdate, DATEADD(MONTH, DATEDIFF(MONTH, Birthdate, GETDATE()), DATEADD(YEAR, DATEDIFF(YEAR, Birthdate, GETDATE()), Birthdate))) AS [Age in Days],
	   DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
FROM People