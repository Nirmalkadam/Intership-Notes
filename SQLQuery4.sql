--- Creating Database
CREATE DATABASE EmployeeDB_1;

--- Use Database
USE EmployeeDB_1;

--- Create Table - 1
CREATE TABLE MasterDesignation(
  ID INT PRIMARY KEY IDENTITY(1,1),
  DesignationName VARCHAR(30),
);

--- Inserting Designations into MasterDesignation Table
INSERT INTO MasterDesignation (DesignationName) VALUES ('Manager');
INSERT INTO MasterDesignation (DesignationName) VALUES ('Developer');
INSERT INTO MasterDesignation (DesignationName) VALUES ('Analyst');

--- Create Table - 2
CREATE TABLE Employee(
  EmpID INT PRIMARY KEY IDENTITY(1,1),
  EmpName VARCHAR(50),
  Birthdate DATE,
  DesignationID INT FOREIGN KEY REFERENCES MasterDesignation(ID),
  Gender INT,
  EmailID VARCHAR(50),
  MobNO VARCHAR(20),
);



--Right join query
select * from Employee
right join MasterDesignation ON Employee.DesignationID = MasterDesignation.ID;

--Full (outer) join
select * from Employee 
FULL JOIN MasterDesignation ON Employee.DesignationID = MasterDesignation.ID;

--INNER JOIN QUERY ------
select * 
from MasterDesignation
inner join Employee ON MasterDesignation.ID=Employee.DesignationId;

--LEFT JOIN QUERY------
select * from Employee
inner join MasterDesignation ON Employee.DesignationId=MasterDesignation.ID;


-----INSERT----
GO
CREATE PROCEDURE Usp_InsertNewRecord
  @EmpName VARCHAR(50),
  @Birthdate DATE,
  @DesignationID INT,
  @Gender INT,
  @EmailID VARCHAR(50),
  @MobNO VARCHAR(20)
AS
BEGIN
--- SQL Query {
INSERT INTO Employee(EmpName, Birthdate, DesignationID, Gender, EmailID, MobNO)
VALUES(@EmpName, @Birthdate, @DesignationID, @Gender, @EmailID, @MobNO);
--- SQL Query Closed }
END;

EXEC Usp_InsertNewRecord @EmpName='Raj', @Birthdate='2002-11-16', @DesignationID=1, @Gender=1, @EmailID='aman@gmail.com', @MobNo='2748731798';


----UPDATE-----
GO
CREATE PROCEDURE Usp_UpdateEmployeeList
  @EmployeeID INT,
  @NewEmpName VARCHAR(50)
AS
BEGIN
--- SQL Query {
UPDATE Employee 
SET EmpName=@NewEmpName 
WHERE EmpID=@EmployeeID;
--- SQL Query Closed }
END;

EXEC Usp_UpdateEmployeeList @EmployeeID=1, @NewEmpName='Nirmal';

--------------------GET----------------------------
GO
CREATE PROCEDURE Usp_GetEmployeeDetails
 @EmployeeID INT
 AS
BEGIN

--- SQL Query {
SELECT EmpName, DesignationName, EmailID, MobNO 
FROM Employee
INNER JOIN MasterDesignation ON Employee.DesignationID=MasterDesignation.ID WHERE EmpID=@EmployeeID;
--- SQL Query Closed }
END;

EXEC Usp_GetEmployeeDetails @EmployeeID=2;




-----DELETE------
GO
CREATE PROCEDURE Usp_DeleteEmployeeDetails 
  @EmployeeID INT
AS
BEGIN
--- SQL Query {
DELETE FROM Employee WHERE EmpID=@EmployeeID;
--- SQL Query Closed }
END;

EXEC Usp_DeleteEmployeeDetails @EmployeeID=1;


---SELECT------
SELECT * FROM Employee;



---DROPDOWN LIST--------
GO 
CREATE PROCEDURE Usp_MasterDesignation

AS
BEGIN
---SQL QUERY---
SELECT * FROM MasterDesignation;
END
EXEC Usp_MasterDesignation;