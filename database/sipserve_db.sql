-- Sip and Serve database schema + seed data + image BLOBs

CREATE DATABASE IF NOT EXISTS sipserve_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sipserve_db;

CREATE TABLE users (
                       id         INT AUTO_INCREMENT PRIMARY KEY,
                       full_name  VARCHAR(100) NOT NULL,
                       email      VARCHAR(150) NOT NULL UNIQUE,
                       password   VARCHAR(255) NOT NULL,
                       role       ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO users(full_name,email,password,role)
VALUES(
          'Admin',
          'admin@sipandserve.com',
          'admin123',
          'ADMIN'
      );

ALTER TABLE users
    ADD address VARCHAR(255);

CREATE TABLE categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO categories (name, description) VALUES
    ('Coffee',   'Hot and cold coffee specialties'),
    ('Bakery',   'Freshly baked cakes and pastries'),
    ('Snacks',   'Sandwiches and savory bites'),
    ('Beverage', 'Teas and other refreshing drinks');

CREATE TABLE products (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100)   NOT NULL,
    description  VARCHAR(500),
    price        DECIMAL(10,2)  NOT NULL,
    rating       DECIMAL(2,1)   DEFAULT 0,
    image_url    VARCHAR(255),
    image_data   LONGBLOB,
    image_type   VARCHAR(50),
    category_id  INT,
    is_signature TINYINT(1) DEFAULT 0,
    is_active    TINYINT(1) DEFAULT 1,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO products (name, description, price, rating, image_url, category_id, is_signature) VALUES
    ('Caramel Macchiato Frappe', 'A sweet, blended iced coffee with caramel.',                                                  250.00, 4.8, 'caramel-frappe.jpg', 1, 1),
    ('Chocolate Cake',           'Moist dessert made with cocoa or melted chocolate.',                                          200.00, 4.6, 'chocolate-cake.jpg', 2, 1),
    ('Sandwich',                 'Quick meal made by placing fillings between slices of bread.',                                200.00, 4.4, 'sandwich.jpg',       3, 1),
    ('Latte',                    'Smooth coffee made with espresso and steamed milk.',                                          350.00, 4.9, 'latte.jpg',          1, 1),
    ('Brownie',                  'Rich fudgy chocolate brownie with a crackly top.',                                            180.00, 4.5, 'brownie.jpg',        2, 0),
    ('Matcha Latte',             'Earthy Japanese matcha whisked with steamed milk.',                                           320.00, 4.7, 'matcha.jpg',         1, 0),
    ('Milk Tea',                 'Creamy Nepali-style milk tea, gently spiced.',                                                120.00, 4.3, 'milktea.jpg',        4, 0),
    ('Jam Toast',                'Crisp toast served with house-made fruit jam.',                                               150.00, 4.2, 'jam-toast.jpg',      3, 0);


CREATE TABLE cart (
                      id         INT AUTO_INCREMENT PRIMARY KEY,
                      user_id    INT NOT NULL,
                      product_id INT NOT NULL,
                      quantity   INT DEFAULT 1,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
                      FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                      UNIQUE KEY unique_cart_item (user_id, product_id)
);
CREATE TABLE orders (
                        id           INT AUTO_INCREMENT PRIMARY KEY,
                        user_id      INT            NOT NULL,
                        total_amount DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
                        status       ENUM('PREPARING','READY','DELIVERED','CANCELLED') DEFAULT 'PREPARING',
                        created_at   TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
                        updated_at   TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE order_items (
                             id         INT AUTO_INCREMENT PRIMARY KEY,
                             order_id   INT            NOT NULL,
                             product_id INT            NOT NULL,
                             quantity   INT            NOT NULL DEFAULT 1,
                             unit_price DECIMAL(10,2)  NOT NULL,
                             created_at TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (order_id)   REFERENCES orders(id)   ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE payments (
                          id         INT AUTO_INCREMENT PRIMARY KEY,
                          order_id   INT            NOT NULL UNIQUE,
                          amount     DECIMAL(10,2)  NOT NULL,
                          status     ENUM('PENDING','COMPLETED','FAILED','REFUNDED') DEFAULT 'PENDING',
                          method     ENUM('CASH','CARD','ONLINE')                    DEFAULT 'CASH',
                          paid_at    TIMESTAMP      NULL,
                          created_at TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE feedback (
                          id         INT AUTO_INCREMENT PRIMARY KEY,
                          user_id    INT     NOT NULL,
                          product_id INT     NOT NULL,
                          rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
                          review     TEXT,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
                          FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                          UNIQUE KEY unique_feedback (user_id, product_id)
) ENGINE=InnoDB;