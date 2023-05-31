TechConnect:


INSERT INTO "user" (firstName, lastName, email, password) VALUES ('Leo', 'Antonio', 'leo.antonio@gmail.com', 'password');


INSERT INTO userRole (userId, roleId) VALUES (1, 1);

INSERT INTO category (name) VALUES ('Technologie');

TechForum:

INSERT INTO tech (name) VALUES ('JavaScript');

INSERT INTO issue (title, description, techId, userId, resolved, resolvedBy) VALUES ('Bug in code', 'I encountered a bug in my pipeline on deploy', 1, 1, false, NULL);

INSERT INTO answer (issueId, description, userId) VALUES (1, 'You should check your syntax.', 2, false, 1);

INSERT INTO answerVote (answerId, vote, userId) VALUES (1, 1, 3);

TechMarket:

INSERT INTO product (name, description, image, price, categoryId) VALUES ('Laptop', 'Powerful laptop for gaming.', 'urlurl', 1500.00, 1);

INSERT INTO ShippingAddress (userId, recipientName, streetNumber, streetName, addressComplement, postalCode, city) VALUES (1, 'Leo Antonio', 123, 'Main Street', 'Apt 4B', '7504', 'Paris');

INSERT INTO BillingAddress (userId, recipientName, streetNumber, streetName, addressComplement, postalCode, city) VALUES (1, 'Leo Antonio', 123, 'Main Street', 'Apt 4B', '7504', 'Paris');


INSERT INTO cart (cartProductId, userId, orderId) VALUES (1, 1, NULL);

INSERT INTO cartProduct (cartId, productId) VALUES (1, 1);

INSERT INTO "order" (cartId, userId) VALUES (1, 1);

INSERT INTO orderDetails (productId, orderNumber, quantity) VALUES (1, 123456, 2);

TechDesigns:
INSERT INTO design (name, description, figmaLink, userId, categoryId) VALUES ('Website Design', 'A modern website design.', 'figma.com/example', 1, 1);