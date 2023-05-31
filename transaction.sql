-- Start transaction
BEGIN;

-- Insert user in table  "user"
INSERT INTO "user" (firstName, lastName, email, password) VALUES ('John', 'Doe', 'johndoe@example.com', 'password123');

-- Get user id 
DECLARE @userId INTEGER;
SELECT @userId = id FROM "user" WHERE email = 'johndoe@example.com';

-- Insert 1 Shipping address for user 
INSERT INTO ShippingAddress (userId, recipientName, streetNumber, streetName, addressComplement, postalCode, city) VALUES (@userId, 'John Doe', 123, 'Main Street', 'Apt 4B', '12345', 'City');

-- Insert 1 Billing address for user 
INSERT INTO BillingAddress (userId, recipientName, streetNumber, streetName, addressComplement, postalCode, city) VALUES (@userId, 'John Doe', 123, 'Main Street', 'Apt 4B', '12345', 'City');

-- Insert 1 product in Product table  "product"
INSERT INTO product (name, description, image, price, categoryId) VALUES ('Smartphone XYZ', 'Ce smartphone XYZ offre des performances avancées et une caméra de haute qualité.', 'smartphone_xyz.jpg',  499.99, 1);

-- Add product in user cart
DECLARE @cartId INTEGER;
SELECT @cartId = id FROM cart WHERE userId = @userId;

INSERT INTO cartProduct (cartId, productId) VALUES (@cartId, 1);

-- Validated transaction 
COMMIT;
