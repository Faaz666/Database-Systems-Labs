--Faaz Shahab (fs09911)

--1
SELECT * FROM Customers

--2
select OrderID, OrderDate, ShipCity, ShipCountry from Orders

--3
select OrderId, OrderDate, CustomerID from Orders where ShipCountry = 'France'

--4
select OrderId, OrderDate, CustomerID from Orders where ShipCountry = 'France' or ShipCountry = 'Brazil'

--5
select OrderId, OrderDate, CustomerID from Orders where (ShipCountry = 'France' or ShipCountry = 'Sweden') and Freight > 40

--6
select TitleOfCourtesy+' '+FirstName+' '+LastName as Employees from Employees 

--7
select OrderId, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry from Orders where ShipAddress like '%box%'

--8
select OrderId, CustomerId from Orders where CustomerID like 'C%S'

--9
select TitleOfCourtesy+' '+FirstName+' '+LastName as Employees from Employees where DATEDIFF(year, HireDate, GETDATE()) > 10

--10
select *, DATEDIFF(day, OrderDate, ShippedDate) as time from Orders 

--11
select ContactName from Customers where Fax is null

--12
select * from Products where QuantityPerUnit like '%box%'
