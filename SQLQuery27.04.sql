SELECT COUNT(*) AS Count
	FROM [dbo].[WizzardDeposits]

SELECT 
	*
	FROM
	[dbo].[WizzardDeposits] AS wd

SELECT MAX(wd.MagicWandSize) AS LongestMagicWand
	FROM
	[dbo].[WizzardDeposits] AS wd;

SELECT TOP(2)
	wd.DepositGroup
	FROM
	[dbo].[WizzardDeposits] AS wd
	GROUP BY wd.DepositGroup
	ORDER BY AVG(wd.MagicWandSize);

SELECT 
	wd.DepositGroup, SUM(wd.DepositAmount) AS TotalSum
	FROM
	[dbo].[WizzardDeposits] AS wd
	GROUP BY wd.DepositGroup

SELECT 
	wd.DepositGroup, SUM(wd.DepositAmount) AS TotalSum
	FROM
	[dbo].[WizzardDeposits] AS wd
	WHERE wd.MagicWandCreator = 'Ollivander family'
	GROUP BY wd.DepositGroup;

SELECT 
	wd.DepositGroup, SUM(wd.DepositAmount) AS TotalSum
	FROM
	[dbo].[WizzardDeposits] AS wd
	WHERE wd.MagicWandCreator = 'Ollivander family'
	GROUP BY wd.DepositGroup
	HAVING SUM(wd.DepositAmount) < 150000
	ORDER BY wd.DepositGroup DESC;
	
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS [MinDepositCharge]
	FROM [dbo].[WizzardDeposits] AS wd
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY MagicWandCreator, DepositGroup;

SELECT AgeGroup, COUNT(*) AS [WizardsCount] 
	FROM (SELECT 
		  CASE
			WHEN Age <= 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'	
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN Age > 61 THEN '[61+]'
			ELSE '[61+]'
		  END AS AgeGroup
	FROM [dbo].[WizzardDeposits]
		) AS [AgeGroupQuery]
	GROUP BY AgeGroup;

SELECT 
	SUBSTRING(FirstName, 1,1) AS [FirstLetter]
	FROM [dbo].[WizzardDeposits] AS wd
	WHERE wd.DepositGroup = 'Troll Chest'
	GROUP BY SUBSTRING(FirstName, 1,1) 

SELECT * FROM [dbo].[WizzardDeposits]



SELECT 
	wd.DepositGroup, wd.IsDepositExpired, AVG(wd.DepositInterest) AS [AverageInterest]
	FROM [dbo].[WizzardDeposits] AS wd
	WHERE wd.DepositStartDate > '01/01/1985'
	GROUP BY wd.DepositGroup, wd.IsDepositExpired
	ORDER BY wd.DepositGroup DESC, wd.IsDepositExpired;


SELECT SUM([Difference]) AS [SumDifference] FROM 
		(SELECT FirstName AS [Host Wizard], DepositAmount AS [Host Wizard Deposit],
		LEAD(FirstName) OVER (ORDER BY Id ASC) AS [Guest Wizard],
		LEAD(DepositAmount) OVER (ORDER BY Id ASC) AS [Guest Wizard Deposit],
		DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id ASC) AS [Difference]
		FROM [dbo].[WizzardDeposits] AS wd
		) AS [LeadQuery]
	WHERE [Difference] IS NOT NULL;

USE SoftUni
	
SELECT DepartmentID, SUM(Salary) AS [TotalSalary]
	FROM [dbo].[Employees]
	GROUP BY DepartmentID
	ORDER BY DepartmentID;

SELECT DepartmentID, MIN(Salary) AS [MinimumSalary]
	FROM [dbo].[Employees]
	WHERE DepartmentID IN (2,5,7) AND HireDate > '01/01/2000'
	GROUP BY DepartmentID;

SELECT * INTO [NewTable]
	FROM [dbo].[Employees]
	WHERE Salary > 30000

DELETE FROM NewTable
	WHERE ManagerID = 42

UPDATE NewTable
	SET Salary += 5000
	WHERE DepartmentID=1 

SELECT DepartmentID, AVG(Salary) AS [AverageSalary]
	FROM NewTable
	GROUP BY DepartmentID;

SELECT DepartmentID, MAX(Salary) AS [MaxSalary] 
	FROM [dbo].[Employees]
	WHERE Salary NOT BETWEEN 30000 AND 70000
	GROUP BY DepartmentID;
	
SELECT DepartmentID, MAX(Salary) AS [MaxSalary] 
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

SELECT COUNT(*) AS [Count]
	FROM [dbo].[Employees]
	GROUP BY ManagerID
	HAVING ManagerID IS NULL;

 SELECT DepartmentID, Salary AS [ThirdHighestSalary] FROM
			(SELECT DepartmentID, Salary,
			DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS [SalaryRank]
			FROM [dbo].[Employees]) AS SalaryRankQuery
	WHERE SalaryRank = 3
	GROUP BY DepartmentID, Salary;


SELECT TOP(10) 
	   e1.FirstName,
	   e1.LastName,
	   e1.DepartmentID
	FROM [dbo].[Employees] AS e1
	WHERE e1.Salary > (SELECT AVG(Salary) AS [AvgSalary]
					  FROM [dbo].[Employees] AS e2
					  WHERE e2.DepartmentID = e1.DepartmentID
					  GROUP BY DepartmentID) 
	ORDER BY e1.DepartmentID;