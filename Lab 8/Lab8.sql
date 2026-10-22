--Q1
select top 1 EmployeeID from Orders
where YEAR(OrderDate) = 1998

--Q2
select EmployeeID from Employees
where ReportsTo in 
(select EmployeeID from Employees 
where ReportsTo is NULL)

--Q3
select distinct EmployeeID from EmployeeTerritories
where TerritoryID in
(select TerritoryID from Territories
where RegionID in
(select RegionID from Region
where RegionDescription = 'Western' or RegionDescription = 'Eastern'))

--Q4
(select ContactName from Suppliers 
where Country = 'Germany') union
(select ContactName from Customers 
where Country = 'Germany')

--Q5
select top 1 ProductName from Products
where ProductID in
(select top 3 ProductID from Products
order by UnitPrice DESC)
order by UnitPrice ASC

--Q6
(select EmployeeID, 3 as 'SeniorityLevel' from Employees
where EmployeeID in
(select EmployeeID from Employees
where DATEDIFF(year,HireDate,GETDATE()) > 5))
union
select EmployeeID, 2  as 'SeniorityLevel' from Employees
where EmployeeID in
(select EmployeeID from Employees
where DATEDIFF(year,HireDate,GETDATE()) < 5 and DATEDIFF(year,HireDate,GETDATE()) > 3)
union
(select EmployeeID, 1  as 'SeniorityLevel' from Employees
where EmployeeID in
(select EmployeeID from Employees
where DATEDIFF(year,HireDate,GETDATE()) < 3))

--Q7
select ProductName,
case 
when UnitPrice > 80 then 'Costly'
when UnitPrice >= 30 then 'Economical'
else 'Cheap'
end as Type
from Products

--Q8
select ProductName,
case
when UnitsOnOrder >= 50 then 'Customer favourite'
when UnitsOnOrder >= 30 then 'Trending'
when UnitsOnOrder >= 10 then 'on the rise'
else 'not popular'
end
as 'Trend'
from Products
where ProductID in
(select ProductID from [Order Details]
where OrderID in
(select OrderID from Orders
where year(OrderDate) = '1997'))

--Q9
select CustomerID, (select count(OrderID) from Orders O where C.CustomerID = O.CustomerID) as 'OrderCount' from Customers C
group by CustomerID

--Q10
select distinct CustomerID from Orders
where OrderID in
(select OrderID from [Order Details]
where ProductID in
(select ProductID from Products
where UnitPrice >
(select avg(UnitPrice) from Products)))

--Q11
select ContactName from Customers
where CustomerID in
(select CustomerID from Orders
where OrderID in
(select OrderID from [Order Details]
where ProductID in
(select ProductID from Products
where CategoryID in
(select CategoryID from Products
where ProductName = 'Chai'))))

--Q12
select top 1 ContactName, (select count(OrderID) from Orders O where O.CustomerID = C.CustomerID) as 'NumberOfOrders' from Customers C
order by NumberOfOrders DESC

--Q13
select ContactName from Customers
where CustomerID in
(select CustomerID from Orders
where OrderID in
(select OrderID from [Order Details]
where ProductID in
(select ProductID from Products
where UnitPrice =
(select max(UnitPrice) from Products))))

--Q14
select avg(ProductCount * 1.0) as 'AverageProductsPerOrder' from
(select count(ProductID) as 'ProductCount' from [Order Details]
group by OrderID) as T

--Q15
select CategoryName from Categories
where CategoryID in
(select CategoryID from Products
group by CategoryID
having avg(UnitPrice) >
(select avg(UnitPrice) from Products))

--Q16
select top 1 ProductName, UnitPrice from Products
where UnitPrice <
(select max(UnitPrice) from Products)
order by UnitPrice DESC

--Q17
select avg(OrderAmount) as 'AverageOrderAmount' from
(select sum(UnitPrice * Quantity * (1 - Discount)) as 'OrderAmount' from [Order Details]
where OrderID in
(select OrderID from Orders
where CustomerID in
(select CustomerID from Customers
where Country = 'France'))
group by OrderID) as T


