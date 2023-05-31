-- Domain
CREATE DOMAIN Password AS VARCHAR(100)
  CHECK (length(VALUE) >= 8);

-- TechConnect
CREATE TABLE "user" (
  id BIGSERIAL PRIMARY KEY,
   firstName  VARCHAR(50) NOT NULL,
   lastName  VARCHAR(50) NOT NULL,
   email  VARCHAR(100) NOT NULL,
   password Password NOT NULL,
   createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
   updatedAt TIMESTAMP
);

CREATE TABLE userRole (
  id BIGSERIAL PRIMARY KEY,
  userId INTEGER REFERENCES "user" ("id"),
  roleId INTEGER REFERENCES "role" ("id"),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);

CREATE TABLE category (
   id BIGSERIAL PRIMARY KEY,
   name  VARCHAR(255),
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updatedAt TIMESTAMP
);



-- TechForum

CREATE TABLE tech (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(50) ,
  createdA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);


CREATE TABLE issue (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(50)  NOT NULL,
  description VARCHAR(200)  NOT NULL,
  techId INTEGER REFERENCES "tech" ("id"),
  userId INTEGER REFERENCES "user" ("id"),
  resolved BOOLEAN  NOT NULL,
  resolvedBy INTEGER REFERENCES "user" ("id"),
  createdA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);


CREATE TABLE answer (
  id BIGSERIAL PRIMARY KEY,
  issueId INTEGER REFERENCES "issue" ("id"),
  description VARCHAR(250)  NOT NULL,
  userId INTEGER REFERENCES "user" ("id"),
  approved BOOLEAN ,
  approvedByUser INTEGER REFERENCES "user" ("id"),
  createdA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);


CREATE TABLE answerVote (
  id BIGSERIAL PRIMARY KEY,
  answerId INTEGER REFERENCES "answer" ("id"),
  vote INTEGER,
  userId INTEGER REFERENCES "user" ("id"),
  createdA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);


-- TechMarket

CREATE TABLE product (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(50)  NOT NULL,
  description VARCHAR(255)  NOT NULL,
  image VARCHAR(200)  NOT NULL,
  price FLOAT  NOT NULL,
  categoryId INTEGER REFERENCES "category" ("id"),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);

-- Trigger for product updatedAt BIGINT
CREATE TRIGGER product_update_trigger
  BEFORE UPDATE ON product
  FOR EACH ROW
  BEGIN    NEW.updatedAt = CURRENT_TIMESTAMP;
  END;




CREATE TABLE ShippingAddress (
   id BIGSERIAL PRIMARY KEY,
   userId  INTEGER REFERENCES "user" ("id"),
   recipientName  VARCHAR(50)  NOT NULL,
   streetNumber  INTEGER  NOT NULL,
   streetName  VARCHAR(100) NOT NULL,
   addressComplement  VARCHAR(150),
   postalCode  VARCHAR(100) NOT NULL,
   city  VARCHAR(100) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updatedAt TIMESTAMP
);


CREATE TABLE BillingAddress (
   id BIGSERIAL PRIMARY KEY,
   userId  INTEGER REFERENCES "user" ("id"),
   recipientName  VARCHAR(50)  NOT NULL,
   streetNumber  INTEGER  NOT NULL,
   streetName  VARCHAR(100) NOT NULL,
   addressComplement  VARCHAR(150) NOT NULL,
   postalCode  VARCHAR(100) NOT NULL,
   city  VARCHAR(100) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updatedAt TIMESTAMP
);

CREATE TABLE cart (
  id BIGSERIAL PRIMARY KEY,
  cartProductId INTEGER REFERENCES "cartProduct" ("id"),
  userId  INTEGER REFERENCES "user" ("id"),
  orderId  INTEGER REFERENCES "order" ("id"),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
)
CREATE TABLE cartProduct (
  id BIGSERIAL PRIMARY KEY,
  cartId INTEGER REFERENCES "cart" ("id"),
  productId  INTEGER REFERENCES "product" ("id"),
)


-- function for generate order number 
CREATE SEQUENCE order_number_seq;
  CREATE OR REPLACE FUNCTION generate_order_number()    
    RETURNS INTEGER AS $$
   DECLARE
     order_number INTEGER;
   BEGIN
     LOOP
       order_number := nextval('order_number_seq');
       EXIT WHEN NOT EXISTS (
         SELECT 1 FROM "order" WHERE "orderNumber" = order_number
       );
     END LOOP;
  
     RETURN order_number;
   END;
   $$ LANGUAGE plpgsql;


CREATE TABLE "order" (
  id BIGSERIAL PRIMARY KEY,
  cartId INTEGER REFERENCES "cart" ("id"),
  userId  INTEGER REFERENCES "user" ("id"),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);

ALTER TABLE "order"
  ALTER COLUMN "orderNumber" SET DEFAULT generate_order_number();

CREATE TABLE orderDetails (
  id BIGSERIAL PRIMARY KEY,
  productId INTEGER REFERENCES "product" ("id"),
  orderNumber INTEGER NOT NULL,  
  quantity INTEGER NOT NULL,
  createdA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
);

-- TechDesigns 
CREATE TABLE design (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(200)  NOT NULL,
  figmaLink VARCHAR(200)  NOT NULL,
  userId INTEGER REFERENCES "user" ("id"),
  categoryId INTEGER REFERENCES "category" ("id"),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP
)


-- Views for to show product details and product category 
CREATE VIEW product_details AS
SELECT p.id, p.name, p.description, p.image, p.price, c.name AS category
FROM product p
JOIN category c ON p.categoryId = c.id;

-- Views for to show user and  their role 
CREATE VIEW user_roles AS
SELECT u.id, u.firstName, u.lastName, u.email, r.name AS role
FROM "user" u
JOIN userRole ur ON u.id = ur.userId
JOIN role r ON ur.roleId = r.id;





















