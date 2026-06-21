CREATE DATABASE restaurant_reviews;

-- Create Table
CREATE TABLE restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    street_adress VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE review (
    id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    user_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

-- Insert into the table
INSERT INTO restaurant (id, name, street_adress, description) VALUES
(1, 'Pizzalicious', 'Jl. Ketabang No. 45, Surabaya', 'Pizza-nya Delicious!!!'),
(2, 'Super Foodie', 'Jl. Lontar No. 19, Surabaya', 'Lives up to the name, SUPER!!!'),
(3, 'Eating at least', 'Jl. G-Walk No. 15, Surabaya', 'Better eating at least'),
(4, 'Nasi Padang Gak Sederhana', 'Jl. Jember No. 2, Surabaya', 'Soalnya lebih dari sederhana!');

INSERT INTO review (id, restaurant_id, user_name, rating, review_text, review_date) VALUES
(1, 1, 'Fang Runin', 4, 'Lumayan lah', '2026-02-25'),
(2, 4, 'Yin Nezha', 4, 'Harganya juga gak sederhana sih tp oke lah', '2026-04-13'),
(3, 2, 'Su Daji', 3, 'Biasa aja, kurang nendang rasanya', '2026-03-12'),
(4, 3, 'Kitay Chen', 5, 'Konsep namanya bagus, rasanya oke.', '2026-04-13'),
(5, 2, 'Jiang Ziya', 3, 'Bumbunya banyakin lah', '2026-03-30'),
(6, 1, 'Venka', 3, 'As a big fan of pizza, this is not that good', '2026-04-13');

-- PERFORMING CRUD

-- INSERT
INSERT INTO restaurant (id, name, street_adress, description) VALUES
(5, 'Eat ate', 'Jl. Malioboro No. 26, Surabaya', 'Ate and left no crumbs'),
(6, 'Somewhere Only We Know', 'Jl. Citra Land No. 22, Surabaya', 'The place we love');

INSERT INTO review (id, restaurant_id, user_name, rating, review_text, review_date) VALUES
(7, 5, 'Altan Trengsin', 4, 'No crumbs', '2026-02-10'),
(8, 6, 'The Red', 5, 'Bruh the nuances, I cant', '2026-04-17');

-- SELECT
SELECT * FROM restaurant;
SELECT * FROM review;

SELECT * FROM review WHERE restaurant_id = 2;
SELECT * from review where rating >= 4;

SELECT t1.name, t2.user_name, t2.rating, t2.review_text
FROM restaurant as t1 JOIN review as t2
ON t1.id = t2.restaurant_id ORDER BY t2.rating DESC;

-- UPDATE
UPDATE restaurant SET description = 'Hidup aja yang sederhana, nasi padang jangan.'
WHERE id = 4 and name = 'Nasi Padang Gak Sederhana';

select name, description from restaurant;

UPDATE review SET rating = 4, review_text = 'For the cheap price, its a good one'
WHERE user_name = 'Venka' and restaurant_id = 1;

SELECT user_name, rating, review_text from review;

-- DELETE one review based on id.
DELETE FROM review WHERE id = '2';
select * from review;

-- DELETE a restaurant and ensure its associated reviews are also deleted
ALTER TABLE review DROP CONSTRAINT review_restaurant_id_fkey;
ALTER TABLE review ADD CONSTRAINT review_restaurant_fkey
FOREIGN KEY (restaurant_id) REFERENCES restaurant(id) ON DELETE CASCADE;

DELETE FROM restaurant WHERE id = '5';

SELECT t1.id, t1.name, t2.user_name, t2.rating, t2.review_text
FROM restaurant as t1 JOIN review as t2
ON t1.id = t2.restaurant_id;

-- ADDITIONAL QUERIES
SELECT t1.name, avg(t2.rating) as avg_rating
FROM restaurant as t1 JOIN review as t2
ON t1.id = t2.restaurant_id
GROUP BY t1.name
ORDER BY avg_rating DESC 
LIMIT 1;

SELECT t1.name, count(t2.id) as total_review
FROM restaurant as t1 JOIN review as t2
ON t1.id = t2.restaurant_id
GROUP BY t1.name;