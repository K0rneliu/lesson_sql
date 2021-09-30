
--lesson 8 ex1
-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT to_user_id, users.first_name AS Name
    , COUNT(*) AS send1 
FROM messages 
JOIN users ON users.id = messages.to_user_id
WHERE from_user_id=19
UNION SELECT to_user_id, users.first_name as Name
    , COUNT(*) AS send 
FROM messages 
JOIN users ON users.id = messages.to_user_id
WHERE from_user_id=19
GROUP BY to_user_id
ORDER BY send1 DESC;
--хотел посчитать не только кому отправлено но и от кого получено,  и потом сумировать и определить max. Но обединение не дается.

-- lesson 8 ex2
-- 2. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
users.gender FROM likes
JOIN users on users.id = likes.user_id
GROUP by gender
SELECT COUNT(*) FROM likes;

-- lesson 8 ex3
-- 3.Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT count( likes.user_id )
FROM users
JOIN likes on likes.user_id=users.id
WHERE (YEAR(NOW())-YEAR(birthday)) < 10;