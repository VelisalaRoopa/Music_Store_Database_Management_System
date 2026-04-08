-- 1
SELECT *
FROM Employee
ORDER BY levels DESC
LIMIT 1;

-- 2
SELECT billing_country, COUNT(*) AS invoice_count
FROM Invoice
GROUP BY billing_country
ORDER BY invoice_count DESC;

-- 3
SELECT total
FROM Invoice
ORDER BY total DESC
LIMIT 3;

-- 4
SELECT billing_city, SUM(total) AS total_revenue
FROM Invoice
GROUP BY billing_city
ORDER BY total_revenue DESC
LIMIT 1;

-- 5
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- 6
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email;

-- 7
SELECT ar.name AS artist_name, COUNT(*) AS track_count
FROM Artist ar
JOIN Album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id
ORDER BY track_count DESC
LIMIT 10;

-- 8
SELECT name, milliseconds
FROM Track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track)
ORDER BY milliseconds DESC;

-- 9
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Album al ON t.album_id = al.album_id
JOIN Artist ar ON al.artist_id = ar.artist_id
GROUP BY c.customer_id, ar.artist_id
ORDER BY total_spent DESC;

-- 10
WITH genre_sales AS (
    SELECT 
        i.billing_country,
        g.name AS genre,
        COUNT(*) AS purchases
    FROM Invoice i
    JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY i.billing_country, g.name
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY billing_country ORDER BY purchases DESC) AS rnk
    FROM genre_sales
)
SELECT billing_country, genre, purchases
FROM ranked
WHERE rnk = 1;

-- 11
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        i.billing_country,
        SUM(i.total) AS total_spent
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, i.billing_country
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY billing_country ORDER BY total_spent DESC) AS rnk
    FROM customer_spending
)
SELECT billing_country, first_name, last_name, total_spent
FROM ranked
WHERE rnk = 1;