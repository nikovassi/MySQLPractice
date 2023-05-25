USE SoftUni

SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[Addresses] AS a ON e.AddressID = a.AddressID
	ORDER BY e.AddressID;

SELECT TOP(50) 
	e.FirstName, e.LastName, t.Name AS Town, a.AddressText 
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[Addresses] AS a ON e.AddressID = a.AddressID
	JOIN [dbo].[Towns] AS t ON a.TownID = t.TownID
	ORDER BY FirstName, LastName;

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS DepartmentName 
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[Departments] AS d ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
	ORDER BY EmployeeID;

SELECT TOP(5)
	e.EmployeeID, e.FirstName, e.Salary, d.Name AS DepartmentName 
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[Departments] AS d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY d.DepartmentID;


SELECT TOP(3)
	e.EmployeeID, e.FirstName 
	FROM [dbo].[Employees] AS e
	LEFT JOIN [dbo].[EmployeesProjects] AS ep 
	ON e.EmployeeID = ep.EmployeeID
	WHERE ep.EmployeeID IS NULL
	ORDER BY e.EmployeeID;

SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName 
		FROM [dbo].[Employees] AS e
		LEFT JOIN [dbo].[Departments] AS d ON e.DepartmentID = d.DepartmentID
		WHERE e.HireDate > '1999.1.1' 
		AND d.Name IN('Sales', 'Finance')
		ORDER BY e.HireDate;

SELECT TOP (5) 
	e.EmployeeID,e.FirstName, p.Name AS projectName 
	FROM [dbo].[Employees] AS e
	JOIN [dbo].[EmployeesProjects] AS ep ON e.EmployeeID = ep.EmployeeID 
	JOIN [dbo].[Projects] AS p ON ep.ProjectID = p.ProjectID
	WHERE P.StartDate > '2002.08.13' AND P.EndDate IS NULL
	ORDER BY E.EmployeeID;

SELECT e.EmployeeID, e.FirstName, 
	CASE
		WHEN DATEPART(YEAR, p.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS [ProjectName]
FROM [dbo].[Employees] AS e
	JOIN [dbo].[EmployeesProjects] AS ep ON e.EmployeeID = ep.EmployeeID 
	JOIN [dbo].[Projects] AS p ON ep.ProjectID = p.ProjectID
	WHERE e.EmployeeID = 24; 

SELECT e.EmployeeID, e.FirstName, m.EmployeeID AS ManagerID, m.FirstName AS ManagerName
	FROM [dbo].[Employees] AS e 
	JOIN [dbo].[Employees] AS m ON e.ManagerID = m.EmployeeID
	WHERE m.EmployeeID IN (3,7)	
	ORDER BY e.EmployeeID;

SELECT TOP(50)
	e.EmployeeID, e.FirstName + ' ' + e.LastName AS EmployeeName, m.FirstName + ' ' + m.LastName AS ManagerName, d.Name AS DepartmentName 
	FROM [dbo].[Employees] AS e 
	JOIN [dbo].[Employees] AS m ON e.ManagerID = m.EmployeeID
	JOIN [dbo].[Departments] AS d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID;

SELECT min(avg) AS MinAverageSalary
	FROM ( 
		SELECT AVG(Salary) AS [avg]
		FROM [dbo].[Employees]
		GROUP BY DepartmentID
	) AS AverageSalary;
	
SELECT TOP(1) AVG(Salary) AS MinAverageSalary FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary;

USE [Geography]

SELECT * FROM [dbo].[MountainsCountries]
SELECT * FROM [dbo].[Mountains]
SELECT * FROM [dbo].[Peaks]

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM [dbo].[MountainsCountries] AS mc
	JOIN [dbo].[Mountains] AS m ON mc.MountainId = m.Id
	JOIN [dbo].[Peaks] AS p ON p.MountainId = M.Id
	WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
	ORDER BY p.Elevation DESC;

SELECT 
c.CountryCode, COUNT(m.MountainRange) AS MountainRanges
	FROM [dbo].[Countries] AS c
	JOIN [dbo].[MountainsCountries] AS mc ON c.CountryCode = mc.CountryCode
	JOIN [dbo].[Mountains] AS m ON mc.MountainId = m.Id
	WHERE c.CountryCode IN ('BG', 'RU', 'US')
	GROUP BY c.CountryCode;

SELECT TOP(5)
	c.CountryName, r.RiverName
	FROM [dbo].[Countries] AS c
	LEFT JOIN [dbo].[CountriesRivers] AS cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN [dbo].[Rivers] AS r ON r.Id = cr.RiverId
	WHERE c.ContinentCode = 'AF'
	ORDER BY C.CountryName;


SELECT TOP(5) 
c.CountryName, MAX(p.Elevation) AS HighestPeakElevation, 
			   MAX(r.Length) AS LongestRiverLength
	FROM [dbo].[Countries] AS c
	JOIN [dbo].[MountainsCountries] AS mc ON c.CountryCode = mc.CountryCode
	JOIN [dbo].[Mountains] AS m ON m.Id = mc.MountainId
	JOIN [dbo].[Peaks] AS p ON p.MountainId = mc.MountainId
	JOIN [dbo].[CountriesRivers] AS cr ON cr.CountryCode = c.CountryCode
	JOIN [dbo].[Rivers] AS r ON r.Id = cr.RiverId
	GROUP BY c.CountryName
	ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName ASC

	
SELECT rc.ContinentCode, rc.CurrencyCode, 
rc.Count
FROM (
SELECT c.ContinentCode, c.CurrencyCode, 
COUNT(c.CurrencyCode) AS [Count], 
DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY 
COUNT(c.CurrencyCode) DESC) AS [rank] 
FROM Countries AS c
GROUP BY c.ContinentCode, c.CurrencyCode) AS rc
WHERE rc.rank = 1 and rc.Count > 1;

SELECT COUNT(*) 
FROM [dbo].[Countries] AS c
LEFT JOIN [dbo].[MountainsCountries] AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN [dbo].[Mountains] AS m ON mc.MountainId = m.Id
WHERE m.MountainRange IS NULL;

SELECT *, DENSE_RANK()
		 OVER(PARTITION BY [Country]) ORDER BY [Elevation] DESC) AS [PeakRank]
FROM 
		(SELECT * FROM [dbo].[Countries] AS c
		LEFT JOIN [dbo].[MountainsCountries] AS mc ON c.CountryCode = mc.CountryCode
		LEFT JOIN [dbo].[Mountains] AS m ON mc.MountainId = m.Id
		LEFT JOIN [dbo].[Peaks] AS p ON mc.MountainId = p.MountainId
		) AS [FullQueryInfo]


SELECT TOP (5) WITH TIES c.CountryName, 
	ISNULL(p.PeakName, '(no highest peak)') AS 'HighestPeakName', 
	ISNULL(MAX(p.Elevation), 0) AS 'HighestPeakElevation', 
	ISNULL(m.MountainRange, '(no mountain)')
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId
	GROUP BY c.CountryName, p.PeakName, m.MountainRange
	ORDER BY c.CountryName, p.PeakName
