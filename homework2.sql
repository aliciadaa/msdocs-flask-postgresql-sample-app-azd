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


