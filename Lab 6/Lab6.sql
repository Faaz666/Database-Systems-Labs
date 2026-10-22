--Q1
select COUNT(*) from Customers where Fax = 'NULL'


--Q2
select COUNT(*) from Orders where YEAR(OrderDate) = '1997'

--Q3
select count(*) from customers where ContactTitle = 'Sales Representative'

--Q4
select SUM(Quantity) from [Order Details] where OrderID = '11070'

--Q5
select count(*) from Customers where Country = 'UK' or Country = 'USA'

--Q6
select sum(UnitsInStock) from Products

--Q7
select sum (UnitsInStock * UnitPrice) from Products

--Q8
select count(*) from Employees where City = 'London'

--Q9
select count(*) from employees where TitleOfCourtesy = 'Ms.' or TitleOfCourtesy = 'Mrs.'

--Q10
SELECT Orders.OrderID, Orders.OrderDate, Products.ProductName 
FROM Orders, [Order Details], Products
WHERE Orders.OrderId = [Order Details].OrderID and [Order Details].ProductID = Products.ProductID;

--Q11
SELECT Orders.OrderID, Orders.OrderDate, Products.ProductName, Customers.ContactName
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--Q12
SELECT Orders.OrderID, Orders.OrderDate, Products.ProductName, Categories.CategoryName
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID 
where Categories.CategoryName = 'Seafood' 

--Q13
SELECT Customers.ContactName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

--Q14
SELECT DISTINCT Orders.OrderID
FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID 
where Categories.CategoryName = 'Meat/Poultry' or  Categories.CategoryName = 'Dairy Products'

--Q15
SELECT Employees.FirstName + ' ' + Employees.LastName AS [Employee Full Name], Customers.ContactName AS [Customer Name]
FROM Employees
CROSS JOIN Customers;

--Q16
SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID, Orders.OrderDate, Orders.ShipCity, Orders.ShipCountry, Orders.ShipRegion
From Customers
left join Orders on customers.CustomerID = orders.customerID
AND Orders.ShipRegion IS NULL
order by Customers.CustomerID

--Q17
SELECT Shippers.ShipperID, Shippers.CompanyName AS ShipperName, Customers.CustomerID, Customers.CompanyName, Customers.Country
FROM Shippers
CROSS JOIN Customers
ORDER BY Shippers.ShipperID, Customers.CustomerID;

--Q18
SELECT Employees.EmployeeID, Employees.FirstName + ' ' + Employees.LastName, Manager.FirstName + ' ' + Manager.LastName
FROM Employees
LEFT JOIN Employees AS Manager ON Employees.ReportsTo = Manager.EmployeeID;

--Q19
SELECT Employees.EmployeeID, Employees.FirstName + ' ' + Employees.LastName, Manager.FirstName + ' ' + Manager.LastName, GrandManager.FirstName + ' ' + GrandManager.LastName
FROM Employees
LEFT JOIN Employees AS Manager ON Employees.ReportsTo = Manager.EmployeeID
LEFT JOIN Employees AS GrandManager ON Manager.ReportsTo = GrandManager.EmployeeID;

--Q20
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName
FROM Customers
INNER JOIN Orders O1996 ON Customers.CustomerID = O1996.CustomerID
INNER JOIN Orders O1997 ON Customers.CustomerID = O1997.CustomerID
WHERE YEAR(O1996.OrderDate) = 1996 AND YEAR(O1997.OrderDate) = 1997;