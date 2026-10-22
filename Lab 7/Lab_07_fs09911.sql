--Q1
select Suppliers.CompanyName, count(*) as "No. of Products"
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
group by Suppliers.CompanyName
order by "No. of Products" DESC

--Q2
select Suppliers.CompanyName, Categories.CategoryName, count(*) as "No. of Products", AVG(Products.UnitPrice) as AveragePrice, SUM(Products.UnitsInStock) as "Total Units in Stock"
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID
group by Suppliers.CompanyName, Categories.CategoryName

--Q3
SELECT Suppliers.CompanyName as "Supplier Name"
FROM Suppliers
INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.CompanyName
HAVING COUNT(Products.ProductID) > 4
ORDER BY COUNT(Products.ProductID) DESC;

--Q4
select Region.RegionDescription, count(*) as "No. of Employees"
from EmployeeTerritories
inner join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
inner join Region on Territories.RegionID = Region.RegionID
group by Region.RegionDescription
order by Region.RegionDescription ASC

--Q5
select OrderID, SUM((Quantity*UnitPrice)-Discount) as "Total Amount"
from [Order Details]
group by OrderID

--Q6
select Categories.CategoryName, count(*) as "No. of Products"
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName

--Q7
select Customers.ContactName, Suppliers.CompanyName, count(*) as "No. of Orders"
from Orders
inner join Customers on Orders.CustomerID = Customers.CustomerID
inner join [Order Details] on [Order Details].OrderID = Orders.OrderID
inner join Products on Products.ProductID = [Order Details].ProductID
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
group by Customers.ContactName, Suppliers.CompanyName

--Q8
select (Employees.TitleOfCourtesy + ' ' + Employees.FirstName + ' ' + Employees.LastName) as EmployeeName, YEAR(Orders.OrderDate) as Year, Count(*) as "No. of Orders"
from Orders
inner join Employees on Employees.EmployeeID = Orders.EmployeeID
group by Employees.TitleOfCourtesy, Employees.FirstName, Employees.LastName, YEAR(Orders.OrderDate);

--Q9
select (M.TitleOfCourtesy + ' ' + M.FirstName + ' ' + M.LastName) as "Manager Name", (E.TitleOfCourtesy + ' ' + E.FirstName + ' ' + E.LastName) as "Employee Name", Count(*) as "No. of Orders"
from Orders
inner join Employees E on E.EmployeeID = Orders.EmployeeID
inner join Employees M on E.ReportsTo = M.EmployeeID
group by E.TitleOfCourtesy, E.FirstName, E.LastName, M.TitleOfCourtesy, M.FirstName, M.LastName

--Q10
select Region.RegionDescription as "Region Name", count(*) as "No. of Employees"
from EmployeeTerritories
left join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
left join Region on Territories.RegionID = Region.RegionID
group by Region.RegionDescription

--Q11
select (Employees.TitleOfCourtesy + ' ' + Employees.FirstName + ' ' + Employees.LastName) as EmployeeName, Customers.ContactName
from Employees
cross join Customers
order by Employees.EmployeeID

--Q12
select CustomerID, ContactName
from Customers
order by Country ASC, ContactName ASC

--Q13
select Count(DISTINCT Employees.EmployeeID) as "Number of Employees", Count(DISTINCT Customers.CustomerID) as Customers, Employees.City as CityName
from Employees
left join Customers on Customers.City = Employees.City
group by Employees.City
order by Employees.City

--Q14
select Count(DISTINCT Employees.EmployeeID) as "Number of Employees", Count(DISTINCT Customers.CustomerID) as Customers, Customers.City as CityName
from Employees
full outer join Customers on Customers.City = Employees.City
group by Employees.City, Customers.City
order by Employees.City, Customers.City


--Q15
select (Employees.TitleOfCourtesy + ' ' + Employees.FirstName + ' ' + Employees.LastName) as EmployeeName, Orders.OrderID
from Orders
inner join Employees on Employees.EmployeeID = Orders.EmployeeID
where Orders.RequiredDate < Orders.ShippedDate


--Q16
select [Order Details].ProductID, SUM([Order Details].Quantity) as TotalQuantity
from [Order Details]
group by [Order Details].ProductID
having sum(Quantity) < 200

--Q17
select Orders.CustomerID, count(*) as "Total Number Of Orders"
from Orders
where DATEDIFF(DAY, OrderDate, '1996/12/31') <= 0
group by CustomerID
having count(*) > 15