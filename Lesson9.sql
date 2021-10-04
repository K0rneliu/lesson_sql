/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции./*

CREATE OR REPLACE VIEW products_catalog AS 
SELECT
	p.name AS product,
    c.name AS catalog
FROM
	products AS p
    JOIN catalogs AS c
ON 
	p.catalog_id= c.id;
    
select*from products_catalog;


CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	user_id INT,
	total DECIMAL (11,2) COMMENT 'Cont',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
	) COMMENT = 'conturile user in intern';
 
INSERT INTO accounts (user_id, total) VALUES
	(4, 5000.00),
	(3, 0.00),
    (2, 200.00),
    (NULL, 25000.00);
	

START transaction;
update accounts set total = total - 2000 where id = 4;
update accounts set total = total + 2000 where id=3;
commit;

START transaction;
update accounts set total = total - 20000 where id = 4;
update accounts set total = total + 20000 where id=1;
rollback;
select*from accounts;



select
	p.name,
	c.name
FROM
	products AS p
JOIN
	catalogs AS c
on
	p.catalog_id = c.id;

/* по желанию) Пусть имеется таблица с календарным полем created_at.
В ней размещены разряженые календарные записи за август 2018 года 
'2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте 
запрос, который выводит полный список дат за август, выставляя 
в соседнем поле значение 1, если дата присутствует в исходном 
таблице и 0, если она отсутствует./* 

CREATE TABLE IF NOT EXISTS posts (
	id SERIAL PRIMARY KEY,
    name VARCHAR (255),
    CREATED_AT date not null
    );

	INSERT INTO posts VALUES
    (null, 'una', '2021-09-02'),
    (null, 'dua', '2021-09-04'),
	(null, 'trei', '2021-09-16'),
    (null, 'trei', '2021-09-16');

CREATE TEMPORARY TABLE IF NOT EXISTS last_days (
	day int
    );
INSERT INTO last_days VALUES
	(0), (1), (2), (3), (4), (5), (6), (7), (8),
    (9), (10), (11), (12), (13), (14), (15), (16), (17),
    (18), (19), (20), (21), (22), (23), (24), (25),
    (26), (27), (28), (29);
select 
	DATE(DATE('2021-09-30') - interval l.day DAY) AS day,
    	NOT ISNULL(p.name) AS order_exist
FROM
	last_days as l
LEFT JOIN
	posts AS p
ON 
	DATE(DATE('2021-09-30') - interval l.day DAY) = p.created_at
ORDER BY
	day;
