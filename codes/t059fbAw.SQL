use Northwind
--Dla każdego zamówienia podaj łączną liczbę zamówionych
--jednostek oraz nazwę klienta.
select  CompanyName, sum([Order Details].Quantity)
from Orders
join Customers on orders.CustomerID = Customers.CustomerID
join [Order Details] on [Order Details].OrderID = Orders.OrderID
group by Customers.CustomerID, Customers.CompanyName
--Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, 
--dla których łączna liczbę zamówionych jednostek jest większa niż 250.
select  CompanyName, sum([Order Details].Quantity)
from Orders
join Customers on orders.CustomerID = Customers.CustomerID
join [Order Details] on [Order Details].OrderID = Orders.OrderID
group by customers.CustomerID, Customers.CompanyName having sum([Order Details].Quantity) > 250
--Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
select sum(UnitPrice*Quantity*(1-Discount)) as wartosc, customers.CompanyName
from [Order Details]
join Orders on [Order Details].OrderID = orders.OrderID
join customers on orders.CustomerID = customers.CustomerID
group by [Order Details].OrderID,Customers.CompanyName
--Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, 
--dla których łączna liczba jednostek jest większa niż 250.
select sum(UnitPrice*Quantity*(1-Discount)) as wartosc, customers.CompanyName
from [Order Details]
join Orders on [Order Details].OrderID = orders.OrderID
join customers on orders.CustomerID = customers.CustomerID
group by [Order Details].OrderID,Customers.CompanyName having sum(Quantity)>250
--Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i
-- nazwisko pracownika obsługującego zamówienie
select sum(UnitPrice*Quantity*(1-Discount)) as wartosc, customers.CompanyName, Employees.FirstName, Employees.LastName
from [Order Details]
join Orders on [Order Details].OrderID = orders.OrderID
join customers on orders.CustomerID = customers.CustomerID
join Employees on orders.EmployeeID = Employees.EmployeeID
group by [Order Details].OrderID,Customers.CompanyName, Employees.FirstName, Employees.LastName 
having sum(Quantity)>250
--Dla każdej kategorii produktu (nazwa), podaj łączną liczbę 
--zamówionych przez klientów jednostek towarów.
select CategoryName, sum(UnitsOnOrder) as ilosc
from Categories
join Products on Categories.CategoryID = Products.CategoryID
group by categories.CategoryID, categories.CategoryName
--Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówień
select Categories.CategoryName, sum([Order Details].UnitPrice*Quantity*(1-Discount)) as wartosc
from Categories
join Products on Categories.CategoryID = Products.CategoryID
join [Order Details] on [Order Details].ProductID = Products.ProductID
group by categories.CategoryID, categories.CategoryName
--Posortuj wyniki w zapytaniu z punktu 2.2 wg: 
--a) łącznej wartości zamówień 
--b) łącznej liczby zamówionych przez klientów jednostek towarów.
select Categories.CategoryName, sum([Order Details].UnitPrice*Quantity*(1-Discount)) as wartosc
from Categories
join Products on Categories.CategoryID = Products.CategoryID
join [Order Details] on [Order Details].ProductID = Products.ProductID
group by categories.CategoryID, categories.CategoryName, Products.UnitsOnOrder
order by wartosc, UnitsOnOrder
--Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
select ShipperID, count(*)
from Shippers
join Orders on orders.ShipVia = Shippers.ShipperID
where year(orders.ShippedDate) = 1997 
group by Shippers.ShipperID, shippers.CompanyName

select shipperid, companyname, count(*)
from shippers  
join orders on Shippers.ShipperID = Orders.ShipVia
where year(shippeddate) = 1997
group by shipperid, CompanyName