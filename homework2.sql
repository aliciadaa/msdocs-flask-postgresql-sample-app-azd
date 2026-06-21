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

SELECT DISTINCT ON (t1.restaurant_id) 
t1.review_date, t2.name, t1.user_name, t1.review_text
FROM review as t1
RIGHT JOIN restaurant as t2
ON t1.restaurant_id = t2.id
ORDER BY t1.restaurant_id, t1.review_date DESC;



-- Extra Credit (Optional)
CREATE TABLE menu (
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL, 
    price DECIMAL(10, 2) NOT NULL, 
    description TEXT, 
    PRIMARY KEY (restaurant_id, item_name),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

-- I want to put back the restaurant and the review that I deleted

/* INSERT INTO restaurant (id, name, street_adress, description) VALUES
(5, 'Eat ate', 'Jl. Malioboro No. 26, Surabaya', 'Ate and left no crumbs');

INSERT INTO review (id, restaurant_id, user_name, rating, review_text, review_date) VALUES
(2, 4, 'Yin Nezha', 4, 'Harganya juga gak sederhana sih tp oke lah', '2026-04-13'),
(7, 5, 'Altan Trengsin', 4, 'No crumbs', '2026-02-10'); */

INSERT INTO menu (restaurant_id, item_name, price, description) 
VALUES 
(1, 'Cheese Lovers', 79000, 'A delicious pizza for couple.'),
(1, 'Veggie Pizza', 80000, 'A delicious pizza with vegetables.'),
(1, 'Chicken Supreme', 35000, 'Bake with best chicken.'),
(2, 'Chicken Bowl', 20000, 'Chicken katsu with japanese rice.'),
(2, 'Chips n Dip ', 15000, 'Tortilla chip served with dipping sauce.'),
(2, 'Spaghetti', 25000, 'Carbonara salmon and prawn.'),
(3, 'BBQ Burger', 25000, 'Juicy beef patty with BBQ sauce.'),
(3, 'Chicken Piccata', 40000, 'Parmesan crusted chicken.'),
(3, 'Wagyu Cheese Burger', 60000, 'Juicy beef patty with double cheese.'),
(4, 'Nasi Rendang Daging', 40000, 'Nasi padang dengan rendang daging yang lembut.'),
(4, 'Nasi Tunjang', 45000, 'Nasi padang dengan tunjang dan kuah yang sedap.'),
(4, 'Nasi Kikil', 42000, 'Nasi padang dengan kikil yang mantap.'),
(5, 'Sirloin Crispy Steak', 48000, 'Crispy on the outside, juicy on the inside'),
(5, 'BBQ Chopped Steak', 35000, 'Smokey, savory beef mixed with a sweet and zesty BBQ glaze.'),
(5, 'Mozarella Steak', 45000, 'Tender, juicy meat beneath a soft, stretchy, melted cheese layer.'),
(6, 'Soft Crab Devilled', 100000, 'Sweet seafood mixed with tangy mustard, hot sauce, and spices.'),
(6, 'Mutton Rolls', 70000, 'Savory lamb or goat meat cooked with warm spices, onions, and black pepper.'),
(6, 'Smoked Salmon', 110000, 'Buttery and savory with a distinct, smoky aroma.');

select * from menu;

SELECT t1.name, t2.item_name, avg(t3.rating) as avg_rating
FROM restaurant as t1
JOIN menu as t2 ON t1.id = t2.restaurant_id
JOIN review as t3 ON t1.id = t3.restaurant_id
GROUP BY t1.name, t2.item_name
ORDER BY t1.name;

