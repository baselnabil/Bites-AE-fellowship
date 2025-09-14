-- Active: 1754489673320@@localhost@5432@postgresql

CREATE TABLE updated_subscriptions (
    id INT PRIMARY KEY,
    user_id INT,
    type_id INT,
    amount NUMERIC(10,2),
    start_date DATE,
    expiry_date DATE
);

COPY updated_subscriptions(id,user_id,type_id,amount,start_date,expiry_date)
FROM '/home/basel/fellowship/subscriptions.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE subscriptions (
    id INT PRIMARY KEY,
    user_id INT,
    type_id INT,
    amount NUMERIC(10,2),
    start_date DATE,
    expiry_date DATE
);

DROP table subscriptions ;
DROP TABLE updated_subscriptions;
COPY updated_subscriptions(id,user_id,type_id,amount,start_date,expiry_date)
FROM '/home/basel/fellowship/updated_subscriptions.csv'
DELIMITER ','
CSV HEADER;

select * from updated_subscriptions

SELECT * FROM subscriptions;

SELECT * FROM subscriptions
WHERE type_id = 2;


SELECT * FROM updated_subscriptions
WHERE type_id = 2;


SELECT * FROM subscriptions
WHERE type_id = 3   ;


SELECT * FROM subscriptions
WHERE type_id = 4   


SELECT * FROM subscriptions
WHERE type_id = 5;


select COUNT(*) from subscriptions
WHERE type_id = 1
AND  user_id IN(SELECT user_id FROM updated_subscriptions 
                WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30'
                AND type_id != 1);
SELECT COUNT(DISTINCT s.user_id) AS converted_users
FROM subscriptions s
JOIN subscriptions prev
  ON s.user_id = prev.user_id
WHERE s.start_date BETWEEN '2025-04-01' AND '2025-04-30'
  AND s.type_id < prev.type_id               
  AND prev.start_date < s.start_date;

SELECT COUNT(DISTINCT s.user_id) AS converted_users
FROM subscriptions s
JOIN subscriptions prev
  ON s.user_id = prev.user_id
WHERE s.start_date BETWEEN '2025-06-01' AND '2025-06-30'
  AND s.type_id > 1          
  AND prev.type_id = 1       
  AND prev.start_date < s.start_date;

SELECT COUNT(DISTINCT s.user_id) AS converted_users
FROM subscriptions s
JOIN subscriptions prev
  ON s.user_id = prev.user_id
WHERE s.start_date BETWEEN '2025-06-01' AND '2025-06-30'
  AND s.type_id < prev.type_id               
  AND prev.start_date < s.start_date;


SELECT Count(s.user_id) FROM subscriptions s
JOIN updated_subscriptions us ON s.user_id = us.user_id
WHERE s.type_id < us.type_id
AND s.start_date BETWEEN '2025-04-01' AND '2025-04-30';


SELECT Count(s.user_id) FROM subscriptions s
JOIN updated_subscriptions us ON s.user_id = us.user_id
WHERE s.type_id < us.type_id
AND s.start_date BETWEEN '2025-06-01' AND '2025-06-30';


SELECT COUNT(DISTINCT s1.user_id) AS churned_users
FROM subscriptions s1
LEFT JOIN subscriptions s2
  ON s1.user_id = s2.user_id
 AND DATE_TRUNC('month', s2.start_date) = DATE '2025-11-01'
WHERE DATE_TRUNC('month', s1.start_date) = DATE '2025-10-01'
  AND s2.user_id IS NULL;


INSERT INTO subscriptions (id, user_id, type_id, amount, start_date, expiry_date)
SELECT id, user_id, type_id, amount, start_date, expiry_date
FROM updated_subscriptions
ON CONFLICT (id) DO NOTHING;


SELECT COUNT(*) FROM subscriptions;
SELECT * FROM subscriptions ORDER BY id;
