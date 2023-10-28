CREATE DATABASE alias;
USE alias;


CREATE TABLE user(
                     id int auto_increment,
                     email varchar(255),
                     password varchar(255),
                     first_name varchar(50),
                     last_name varchar(50),
                     address varchar(255),
                     city varchar(255),
                     postalcode int,
                     country varchar(50),
                     phone varchar(10),
                     id_role int,

                     PRIMARY KEY(id)
);

CREATE TABLE role (
                      id int auto_increment,
                      name varchar(255),

                      primary key (id)
);

CREATE TABLE blog(
                     id int auto_increment,
                     id_user int ,
                     title varchar(255),
                     create_date datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                     content longtext,

                     PRIMARY KEY(id)
);

CREATE TABLE review (
                        id int auto_increment,
                        rate bit(5),
                        title varchar(255),
                        content longtext,
                        image blob,
                        id_user int,

                        PRIMARY KEY(id)
);


CREATE TABLE comment (
                         id int auto_increment,
                         id_blog int ,
                         create_date datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         content longtext,

                         PRIMARY KEY(id)
);

CREATE TABLE cart (
                      id int auto_increment,
                      id_user int ,
                      id_product int ,
                      quantity int,

                      PRIMARY KEY(id)
);

CREATE TABLE cart_status_tracking (

                                      id_cart int ,
                                      id_status_tracking int,

                                      PRIMARY KEY(id_cart, id_status_tracking)
);

CREATE TABLE status_tracking (
                                 id int auto_increment,
                                 name varchar(255),
                                 create_date datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

                                 PRIMARY KEY(id)
);

CREATE TABLE product (
                         id int auto_increment,
                         name varchar(100),
                         code varchar(100),
                         quantity int,
                         price int,
                         discount double,
                         description longtext,
                         id_image int,
                         id_size int ,
                         id_category int ,
                         id_review int ,
                         id_color int ,

                         PRIMARY KEY(id)
);

CREATE TABLE size (
                      id int auto_increment,
                      name varchar(100),

                      PRIMARY KEY(id)
);

CREATE TABLE category (
                          id int auto_increment,
                          name varchar(100),

                          PRIMARY KEY(id)
);

CREATE TABLE carousel (
                          id int auto_increment,
                          image blob,
                          title varchar(255),
                          content varchar(255),
                          id_category int ,

                          PRIMARY KEY(id)
);

CREATE TABLE color (
                       id int auto_increment,
                       name varchar(100),

                       PRIMARY KEY(id)
);

CREATE TABLE image(
                      id int auto_increment,
                      content text,

                      primary key (id)
);

CREATE TABLE product_order (
                               id_product int,
                               id_order int,
                               quantity int,
                               price_all decimal(9,2),

                               PRIMARY KEY(id_product, id_order)
);
CREATE TABLE orders
(
    id          int auto_increment,
    id_payment  int,
    id_user     int,
    id_status   int,
    create_date datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    image varchar(255),

    PRIMARY KEY (id)
);


CREATE TABLE status (
                        id int auto_increment,
                        name varchar(50),

                        PRIMARY KEY(id)
);

CREATE TABLE payment (
                         id int auto_increment,
                         name varchar(100),
                         code varchar(100),
                         quantity int,
                         description varchar(255),
                         image varchar(255),
                         id_shipping int ,

                         PRIMARY KEY(id)
);

CREATE TABLE shipping (
                          id int auto_increment,
                          name varchar(100) ,
                          fee decimal(10,2),

                          PRIMARY KEY(id)
);

ALTER TABLE user
    ADD CONSTRAINT fk_user_id_role FOREIGN KEY (id_role)   REFERENCES role (id);

ALTER TABLE blog ADD CONSTRAINT fk_blog_user FOREIGN KEY (id_user) REFERENCES user(id);

ALTER TABLE comment ADD CONSTRAINT fk_comment_blog  FOREIGN KEY (id_blog) REFERENCES blog(id);

ALTER TABLE orders ADD CONSTRAINT fk_orders_user FOREIGN KEY (id_user) REFERENCES user(id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_payment FOREIGN KEY (id_payment) REFERENCES payment(id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_status FOREIGN KEY (id_status) REFERENCES status(id);


ALTER TABLE product_order ADD CONSTRAINT fk_product_order_product FOREIGN KEY (id_product) REFERENCES product(id);
ALTER TABLE product_order ADD CONSTRAINT fk_product_order_order FOREIGN KEY (id_order) REFERENCES orders(id);



ALTER TABLE cart ADD CONSTRAINT fk_cart_user FOREIGN KEY (id_user) REFERENCES user(id);
ALTER TABLE cart ADD CONSTRAINT fk_cart_product FOREIGN KEY (id_product) REFERENCES product(id);


ALTER TABLE cart_status_tracking ADD CONSTRAINT fk_cart_status_tracking_status_tracking
    FOREIGN KEY (id_status_tracking) REFERENCES status_tracking(id);

ALTER TABLE cart_status_tracking ADD CONSTRAINT fk_cart_status_tracking_cart
    FOREIGN KEY (id_cart) REFERENCES cart(id);


ALTER TABLE product ADD CONSTRAINT fk_product_id_image FOREIGN KEY (id_image) REFERENCES image(id);
ALTER TABLE product ADD CONSTRAINT fk_product_size FOREIGN KEY (id_size) REFERENCES size(id);
ALTER TABLE product ADD CONSTRAINT fk_product_category FOREIGN KEY (id_category) REFERENCES category(id);
ALTER TABLE product ADD CONSTRAINT fk_product_review FOREIGN KEY (id_review) REFERENCES review(id);
ALTER TABLE product ADD CONSTRAINT fk_product_color FOREIGN KEY (id_color ) REFERENCES color (id);


ALTER TABLE review ADD CONSTRAINT fk_review_user FOREIGN KEY (id_user) REFERENCES user (id);

ALTER TABLE carousel ADD CONSTRAINT fk_carousel_category FOREIGN KEY (id_category ) REFERENCES category (id);

ALTER TABLE payment  ADD CONSTRAINT fk_payment_shpping  FOREIGN KEY (id_shipping ) REFERENCES shipping (id);
