-------------------------------------- BÀI TẬP APP FOOD ------------------------------

-- Bảng USER
create table `user` (
	user_id int AUTO_INCREMENT PRIMARY KEY,
	full_name varchar(255),
	email varchar(255),
	password varchar(255)
);

-- Dữ liệu user
INSERT INTO `user` (full_name, email, password) VALUES
	("Nguyễn Văn A","A@gmail.com",0099),
	("Nguyễn Văn B","B@gmail.com",0099),
	("Nguyễn Văn C","C@gmail.com",0099),
	("Nguyễn Văn D","D@gmail.com",0099),
	("Nguyễn Văn E","E@gmail.com",0099),
	("Nguyễn Văn F","F@gmail.com",0099);
	("Nguyễn Văn H","H@gmail.com",0099);
	("Nguyễn Văn G","G@gmail.com",0099);


-- Bảng RESTAURANT
	create table `restaurant` (
	res_id int AUTO_INCREMENT PRIMARY KEY,
	res_name varchar(255),
	image varchar(255),
	`desc` varchar(255)
	);
-- Dữ liệu restaurant
INSERT INTO `restaurant` (res_name,image,`desc`) VALUES
	("Restaurant 1","image1","perfect"),
	("Restaurant 2","image2","perfect"),
	("Restaurant 3","image3","perfect")


-- Bảng food_type
CREATE TABLE `food_type` (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100)
);
-- Dữ liệu food_tyoe
INSERT INTO `food_type` (type_name) VALUES
	("Nướng"),
	("Hấp"),
	("Chiên");

-- Bảng FOOD

CREATE TABLE `food` (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(100),
    price FLOAT,
    image VARCHAR(255),
    `desc` TEXT,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES `food_type`(type_id)
);
-- Dữ liệu food
INSERT INTO `food` (food_name,price,image,`desc`,type_id) VALUES
	("Bò","100.000","beef","grill",1),
	("Heo","80.000","pork","steam",2),
	("Cá","70.000","fish","fried",3);
	
-- Bảng sub_food

CREATE TABLE `sub_food` (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(100),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES `food`(food_id)
);

-- Dữ liệu sub_food
INSERT INTO `sub_food` (sub_name, sub_price, food_id) VALUES
('unripe', 90.0000, 1),
('piglet', 70.000, 1),
('live fish', 50.000, 2);




-- Bảng order
CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(100),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES `user`(user_id),
    FOREIGN KEY (food_id) REFERENCES `food`(food_id)
);
-- Dữ liệu order
INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) VALUES
	(1, 1, 2, 'Order1', '1,2'),
	(2, 2, 1, 'Order2', ''),
	(3, 3, 3, 'Order3', '');



-- Bảng like_res
CREATE TABLE `like_res` (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES `user`(user_id),
    FOREIGN KEY (res_id) REFERENCES `restaurant`(res_id)
);
-- Dữ liệu like_res
INSERT INTO `like_res` (user_id, res_id, date_like) VALUES
	(1, 1, NOW()),
	(2, 2, NOW()),
	(3, 1, NOW()),
	(1, 2, NOW()),
	(4, 3, NOW());


-- Bảng rate_res
CREATE TABLE `rate_res` (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES `user`(user_id),
    FOREIGN KEY (res_id) REFERENCES `restaurant`(res_id)
);
-- Dữ liệu rate_res
INSERT INTO `rate_res` (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, NOW()),
(2, 2, 4, NOW()),
(3, 1, 3, NOW());



-- Tìm 5 người đã like nhà hàng nhiều nhất:
SELECT `user`.full_name, COUNT(`like_res`.res_id) AS "số lượt like"
FROM `like_res`
INNER JOIN `user` ON `like_res`.user_id = `user`.user_id
GROUP BY `like_res`.user_id
ORDER BY "số lượt like" DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất:
SELECT `restaurant`.res_name, COUNT(`like_res`.user_id) AS "Số lượt like"
FROM `like_res`
INNER JOIN `restaurant` ON `like_res`.res_id = `restaurant`.res_id
GROUP BY `like_res`.res_id
ORDER BY "Số lượt like" DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất:
SELECT `user`.full_name, COUNT(`order`.order_id) AS "Lượt đặt hàng"
FROM `order` 
INNER JOIN `user` ON `order`.user_id = `user`.user_id
GROUP BY `order`.user_id
ORDER BY "Lượt đặt hàng" DESC


-- Tìm người dùng không hoạt động trong hệ thống:
SELECT `user`.full_name,`like_res`.date_like,`order`.code,`rate_res`.date_rate
FROM `user`
LEFT JOIN `order` ON `user`.user_id = `order`.user_id
LEFT JOIN `like_res` ON `user`.user_id = `like_res`.user_id
LEFT JOIN `rate_res` ON `user`.user_id = `rate_res`.user_id
WHERE `order`.order_id IS NULL
AND `like_res`.res_id IS NULL
AND `rate_res`.res_id IS NULL;


