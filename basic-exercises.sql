-- ============================================
-- CHINOOK SQL EXERCISES
-- ============================================

-- 1. Display a table with full names and countries
--    of all customers not from the USA
SELECT c.FirstName ||' '|| c.LastName AS Full_Name, c.Country
FROM customers c
WHERE c.Country NOT IN ('USA');
-- 2. Display a table with full names and countries
--    of all customers from Brazil
SELECT c.FirstName ||' '|| c.LastName AS Full_Name, c.Country
FROM customers c
WHERE c.Country IN ('Brazil');
-- 3. Display a table with customers' full names,
--    invoice ID, invoice date, and billing country
--    for all customers from France
SELECT c.FirstName ||' '|| c.LastName AS Full_Name, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM customers c
JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE i.BillingCountry IN ('France');
-- 4. Display a table with all distinct employee roles
SELECT DISTINCT Title
FROM employees;
-- 5. Display a table with full names of employees
--    who are 'Sales Support Agent'
SELECT e.FirstName ||' '|| e.LastName AS Full_Name, e.Title
FROM employees e 
WHERE e.Title IN ('Sales Support Agent');
-- 6. Display a table with the number of invoices per country,
--    ordered in descending order
SELECT i.BillingCountry, COUNT(i.InvoiceId) AS Total_Invoices
FROM invoices i
GROUP BY i.BillingCountry 
ORDER BY Total_Invoices DESC;
-- 7. Display a table with the average price per genre,
--    ordered in descending order by average price
SELECT g.Name, ROUND(AVG(t.UnitPrice),2) AS Average_Price 
FROM genres g 
JOIN tracks t ON g.GenreId = t.GenreId 
GROUP BY g.Name 
ORDER BY Average_Price DESC;
-- 8. Display a table with employees who are 'Sales Support Agent'
--    and their total sales, ordered in descending order
SELECT e.FirstName ||' '|| e.LastName AS Full_Name, SUM(i.Total) AS Revenue
FROM employees e 
JOIN customers c ON e.EmployeeId = c.SupportRepId
JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE e.Title = 'Sales Support Agent'
GROUP BY Full_Name
ORDER BY Revenue DESC;
-- 9. Display a table with the number of tracks in each playlist
SELECT p.Name, COUNT(pt.TrackId) AS Total_Tracks
FROM playlist_track pt
JOIN playlists p ON pt.PlaylistId = p.PlaylistId
GROUP BY p.PlaylistId, p.Name
ORDER BY Total_Tracks DESC;
-- 10. Display a table with the number of sales per day
--     for the first 15 days of January 2010
SELECT DATE(InvoiceDate) AS SaleDay, COUNT(InvoiceId) AS TotalSales
FROM invoices
WHERE InvoiceDate >= '2010-01-01' AND InvoiceDate < '2010-01-16'
GROUP BY SaleDay
ORDER BY SaleDay;
-- 11. How many invoices were there in 2009 and in 2013?
--     What was the total sales amount for each of those years?
SELECT strftime('%Y', InvoiceDate) AS Year, COUNT(InvoiceId) AS Total_Invoices, SUM(Total) AS Revenue
FROM invoices
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2013')
GROUP BY Year
ORDER BY Year ASC;
-- 12. How many invoice lines did the invoice with ID 37 have?
SELECT InvoiceId, COUNT(InvoiceLineId) AS Total_Rows
FROM invoice_items
WHERE InvoiceId = 37
GROUP BY InvoiceId;
-- 13. How many invoice lines did each invoice ID have?
SELECT InvoiceId, COUNT(InvoiceLineId) AS Total_Rows
FROM invoice_items
GROUP BY InvoiceId
ORDER BY InvoiceId ASC;
-- 14. Select invoice IDs and their totals where the total is
--     above the average invoice amount
-- 1. General Average
WITH General_Average AS(SELECT ROUND(AVG(Total),2) AS Average FROM Invoices),
-- 2. Revenue of all Invoices 
Total_Revenue AS (SELECT InvoiceId, Total AS Revenue FROM Invoices)
-- 3. Total_Revenue > Average 
SELECT InvoiceId, Revenue 
FROM General_Average, Total_Revenue
WHERE Revenue > General_Average.Average
ORDER BY Revenue ASC;
-- 15. Display a table with customer IDs, their full names,
--     and total amount spent, ordered in descending order
SELECT c.CustomerId, c.FirstName ||' '|| c.LastName AS Full_Name,
SUM(i.Total) AS Total_Expended
FROM customers c 
JOIN invoices i ON c.CustomerId = i.CustomerId 
GROUP BY c.CustomerId 
ORDER BY Total_Expended DESC;
-- 16. Calculate:
--     - number of customers with purchases
--     - number of tracks purchased
--     - average number of tracks purchased per customer (integer, no decimals)
SELECT COUNT(DISTINCT c.CustomerId) AS TotalCustomers, COUNT(iit.TrackId) AS TotalTracks, 
ROUND(COUNT(iit.TrackId) * 1.0 / COUNT(DISTINCT c.CustomerId),0) AS AverageTracksPerCustomer
FROM Customers c
JOIN Invoices i ON c.CustomerId = i.CustomerId
JOIN Invoice_Items iit ON i.InvoiceId = iit.InvoiceId;
-- 17. Display a table with total revenue per month during 2009
SELECT strftime ('%m', InvoiceDate) AS Month, SUM(Total) AS Revenue
FROM invoices
WHERE strftime('%Y', InvoiceDate) = '2009'
GROUP BY Month
ORDER BY Month ASC;
