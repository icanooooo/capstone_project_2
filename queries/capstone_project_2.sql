-- 1. Berapa banyak transaksi dalam table order
SELECT COUNT(id) FROM orders o ;

-- 2. Jumlah order dari seluruh transaksi table order
SELECT SUM(total) FROM orders o ;

-- 3. Jumlah produk yang paling sering memberikan diskon
WITH discount_count AS (
SELECT
	p."title" AS product_title,
	count(o."discount") AS discount_count
FROM products p
LEFT JOIN orders o
ON p."id" = o."product_id"
GROUP BY "product_title"
ORDER BY "discount_count" DESC
LIMIT 10
)

SELECT * FROM discount_count;

-- 4
WITH sum_total_category AS (
SELECT
	p."category",
	sum(o."total") AS sum_total
FROM products p
LEFT JOIN orders o
ON p."id" = o."product_id"
GROUP BY "category"
ORDER BY "sum_total" DESC
)

SELECT * from sum_total_category;

--5 
WITH product_best_rating AS (
SELECT
	p."title" AS product_title,
	p."rating",
	sum(o."total") AS sum_total
FROM products p
LEFT JOIN orders o
ON p."id" = o."product_id"
WHERE rating >= 4
GROUP BY 1, 2
ORDER BY 3 DESC
)

SELECT * FROM product_best_rating;

--6 
WITH doohickey_bad_reviews AS (
SELECT
	r."created_at",
	p."category",
	r."rating",
	r."body"
FROM reviews r
INNER JOIN products p
ON r."product_id" = p."id"
WHERE "category" = 'Doohickey' AND r."rating" <= 3
ORDER BY "created_at" DESC
)

SELECT * FROM doohickey_bad_reviews;

--7 
SELECT
	distinct("source"),
	COUNT("source")
FROM users u
GROUP BY "source";

--8
SELECT COUNT(id) AS "total_users_gmail"
FROM users u
WHERE email like '%gmail.com';

--9
SELECT
	id,
	title, 
	price, 
	created_at
FROM products p 
where price between 30 and 50
ORDER BY created_at DESC;

--10
CREATE VIEW users_younger AS
SELECT
	name,
	email,
	address,
	birth_date
FROM users
WHERE birth_date > '1997'
ORDER BY birth_date;

SELECT * FROM users_younger;

--11 coba lagi
with counted_title AS(
SELECT
	id,
	created_at,
	title,
	category,
	vendor,
	ROW_NUMBER() OVER(PARTITION BY TITLE) AS "title_row_num",
	COUNT(*) OVER(PARTITION BY title) AS number_of_titles
FROM products p
),
multiple_title AS (
SELECT
	*
FROM counted_title
where number_of_titles > 1
)

SELECT * FROM multiple_title;

