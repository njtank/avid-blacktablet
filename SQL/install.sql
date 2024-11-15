CREATE TABLE black_market_listings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id VARCHAR(50),
    item_name VARCHAR(100),
    item_label VARCHAR(100),
    item_price INT,
    item_quantity INT
);
