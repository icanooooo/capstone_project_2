-- 1. Berapa banyak transaksi dalam table order
select count(id) from orders o ;

-- 2. Jumlah order dari seluruh transaksi table order
select sum(total) from orders o ;

-- 3. Jumlah produk yang paling sering memberikan diskon
with joined_orders_products as (
select
	p."id" as product_id,
	p."title" as product_title,
	o."id" as orders_id,
	o."user_id" as user_id,
	o."discount" as discount,
	o."total" as Total
from products p 
left join orders o 
on p."id" = o."product_id"
)

select
	"product_title",
	count("discount") as discount_count
from joined_orders_products
group by "product_title"
order by "discount_count" desc
limit 10;

-- 4
with joined_orders_products as (
select
	p."id" as product_id,
	p."title" as product_title,
	p."category",
	o."id" as orders_id,
	o."user_id" as user_id,
	o."discount" as discount,
	o."total" as total
from products p 
left join orders o 
on p."id" = o."product_id"
)

select
	"category",
	sum("total") as sum_total
from joined_orders_products
group by "category"
order by "sum_total" desc;

--5 
with joined_orders_products as (
select
	p."id" as product_id,
	p."title" as product_title,
	o."id" as orders_id,
	o."user_id" as user_id,
	p."rating",
	o."discount" as discount,
	o."total" as Total
from products p 
left join orders o 
on p."id" = o."product_id"
)

select
	product_title,
	rating,
	sum(total) as sum_total
from joined_orders_products
where rating >= 4
group by 1, 2
order by 3 desc
;

--6 
with joined_reviews_orders as (
select 
	r."id" as review_id,
	r."created_at",
	r."product_id",
	p."title",
	p."category",
	r."rating",
	r."body"
from reviews r 
inner join products p
on r."product_id" = p."id"
)

select
	*
from joined_reviews_orders
where "category" = 'Doohickey' and rating <= 3
order by "created_at" desc;

--7 
select
	distinct("source"),
	count("source")
from users u
group by "source";

--8
select count(id) as "total_users_gmail" from users u where email like '%gmail.com';

--9
select
	id,
	title, 
	price, 
	created_at
from products p 
where price between 30 and 50
order by created_at desc;

--10
create view users_filtered as
select
	name,
	email,
	address,
	birth_date
from users
where birth_date > '1997';
	
select * from users_filtered
order by birth_date desc;

--11 coba lagi
with counted_title as(
select
	id,
	created_at,
	title,
	row_number() over(partition by title) as "title_row_num",
	count(*) over (partition by title) as number_of_titles,
	category,
	vendor
from products p
),
multiple_title as (
select
	*
from counted_title
where number_of_titles > 1
)

select * from multiple_title;

