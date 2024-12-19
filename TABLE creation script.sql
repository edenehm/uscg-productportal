CREATE TABLE recruiting_region(
	recruiting_region_id int(1) NOT NULL auto_increment,
    regional_manager int NOT NULL,
    PRIMARY KEY (recruiting_region_id)
    );

CREATE TABLE recruiting_office(
	office_id int NOT NULL auto_increment,
    office_name varchar(25) NOT NULL,
    office_address varchar(100) NOT NULL,
    office_city varchar(30) NOT NULL,
    office_state char(2) NOT NULL,
    office_zip int(5) NOT NULL,
    office_manager int NOT NULL,
    recruiting_region_id int(1) NOT NULL,
    PRIMARY KEY (office_id)
);

CREATE TABLE recruiters (
	recruiter_id int NOT NULL auto_increment,
    first_name varchar(25) NOT NULL,
    last_name varchar(50) NOT NULL,
    office_id int NOT NULL,
    PRIMARY KEY (recruiter_id) 
);

CREATE TABLE products (
	product_id int NOT NULL auto_increment,
    product_name varchar(50) NOT NULL,
    description varchar(200) NOT NULL,
    vendor_id int NOT NULL,
    unit_cost decimal(13,2) NOT NULL,
    items_per_unit int NOT NULL,
    picture BLOB,
    category_id int NOT NULL,
    PRIMARY KEY(product_id)
);

# Add FOREIGN KEYS    
   
 CREATE TABLE product_category (
	category_id int NOT NULL auto_increment,
    category_name varchar(30) NOT NULL,
    PRIMARY KEY (category_id)
 );

CREATE TABLE inventory (
	product_id int NOT NULL,
    office_id int NOT NULL,
    quantity_instock int NOT NULL,
    minimum_order_quantity int NOT NULL,
    PRIMARY KEY(product_id,office_id)
);
#Add FOREIGN KEYS

CREATE TABLE vendor (
	vendor_id INT NOT NULL auto_increment,
    vendor_address varchar(75) NOT NULL,
    vendor_city varchar(75) NOT NULL,
    vendor_state char(2) NOT NULL,
    vendor_zip int(5) NOT NULL,
    vendor_phone varchar(25) NOT NULL,
    vendor_website varchar(40) NOT NULL,
    PRIMARY KEY(vendor_id)
);
#Add FOREIGN KEYS
CREATE TABLE orders (
	order_id INT NOT NULL auto_increment,
    vendor_id INT NOT NULL,
    product_id INT NOT NULL,
    office_id INT NOT NULL,
    date_ordered DATE NOT NULL,
    date_paid DATE, 
    quantity_oredered INT NOT NULL,
    est_arrival_date DATE,
    PRIMARY KEY(order_id)
);

#ADD FOREIGN KEYS
CREATE TABLE event (
	event_id INT NOT NULL auto_increment,
    event_date DATE NOT NULL,
    event_name varchar(100) NOT NULL,
    event_location_city varchar(75) NOT NULL,
    event_state char(2) NOT NULL,
    event_zip int(5) NOT NULL,
    office_id INT NOT NULL,
    recruiter_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_used INT NULL,
    PRIMARY KEY(event_id) 
    # quantity used will be a problem. will need to figure out how to enable adding multiple products to each event and their associated quantity
);

#ADD FOREIGN KEYS

CREATE TABLE product_event (
	product_id INT NOT NULL,
    event_id INT NOT NULL,
    #Add quantity used here?
    PRIMARY KEY(product_id,event_id)
);

CREATE TABLE recruiter_event(
	recruiter_id INT NOT NULL,
    event_id INT NOT NULL,
    PRIMARY KEY (recruiter_id, event_id)
);
ALTER TABLE recruiting_region 
modify column regional_manager int(11);

ALTER TABLE recruiting_office
modify column office_manager int;

ALTER TABLE recruiting_office
ADD FOREIGN KEY (recruiting_region_id) REFERENCES recruiting_region(recruiting_region_id),
ADD FOREIGN KEY (office_manager) REFERENCES recruiters(recruiter_id);

ALTER TABLE recruiters
ADD FOREIGN KEY (office_id) REFERENCES recruiting_office(office_id);

ALTER TABLE products
ADD FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
ADD FOREIGN KEY (category_id) REFERENCES product_category(category_id);


ALTER TABLE inventory
ADD FOREIGN KEY (product_id) REFERENCES products(product_id),
ADD FOREIGN KEY (office_id) REFERENCES recruiting_office(office_id);

ALTER TABLE recruiter_event
ADD FOREIGN KEY (recruiter_id) REFERENCES recruiters(recruiter_id),
ADD FOREIGN KEY (event_id) REFERENCES event(event_id);

ALTER TABLE orders
ADD FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
ADD FOREIGN KEY (product_id) REFERENCES products(product_id),
ADD FOREIGN KEY (office_id) REFERENCES recruiting_office(office_id);

ALTER TABLE event
ADD FOREIGN KEY (office_id) REFERENCES recruiting_office(office_id),
ADD FOREIGN KEY (recruiter_id) REFERENCES recruiters(recruiter_id);

ALTER TABLE product_event
ADD FOREIGN KEY (product_id) REFERENCES products(product_id),
ADD FOREIGN KEY (event_id) REFERENCES event(event_id);

ALTER TABLE product_event
ADD quantity_used INT NOT NULL;

ALTER TABLE event
DROP quantity_used;

ALTER TABLE product_event
MODIFY column quantity_used INT NOT NULL;

ALTER TABLE recruiting_region
ADD region_name varchar(5) NOT NULL;

ALTER TABLE recruiting_region
DROP regional_manager;

ALTER TABLE recruiting_office
ADD region_name varchar(5) NOT NULL;
 
ALTER TABLE event 
DROP product_id;

ALTER TABLE orders
DROP est_arrival_date;

ALTER TABLE vendor
ADD vendor_name varchar(50);

ALTER TABLE inventory
CHANGE  minimum_order_quantity reorder_point int NOT NULL;

#ALTER TABLE event
#DROP FOREIGN KEY event_ibfk_1,
#DROP FOREIGN KEY event_ibfk_2;

#ALTER TABLE inventory
#DROP FOREIGN KEY inventory_ibfk_1,
#DROP foreign key inventory_ibfk_2,
#DROP FOREIGN KEY inventory_ibfk_3;

#ALTER TABLE orders
#DROP FOREIGN KEY orders_ibfk_1,
#DROP FOREIGN KEY orders_ibfk_2,
#DROP FOREIGN KEY orders_ibfk_3,
#DROP FOREIGN KEY orders_ibfk_4,
#DROP FOREIGN KEY orders_ibfk_5,
#DROP FOREIGN KEY orders_ibfk_6;

#ALTER TABLE product_event
#DROP FOREIGN KEY product_event_ibfk_1,
#DROP FOREIGN KEY product_event_ibfk_2,
#DROP FOREIGN KEY product_event_ibfk_3,
#DROP FOREIGN KEY product_event_ibfk_4;

#ALTER TABLE products
#DROP FOREIGN KEY products_ibfk_1,
#DROP FOREIGN KEY products_ibfk_2,
#DROP FOREIGN KEY products_ibfk_3,
#DROP FOREIGN KEY products_ibfk_4;

#ALTER TABLE recruiter_event
#DROP FOREIGN KEY recruiter_event_ibfk_1,
#DROP FOREIGN KEY recruiter_event_ibfk_2;

#ALTER TABLE recruiters
#DROP FOREIGN KEY recruiters_ibfk_1; 

#ALTER TABLE recruiting_office
#DROP FOREIGN KEY recruiting_office_ibfk_1,
#DROP FOREIGN KEY recruiting_office_ibfk_4;



#DROP TABLE event, inventory, orders, product_category, product_event, products, recruiter_event, recruiters, recruiting_office, recruiting_region, vendor; 

#SET FOREIGN_KEY_CHECKS=0; 
#DROP TABLE recruiters; 
#DROP TABLE recruiting_office;
#DROP TABLE recruiting_region;
#SET FOREIGN_KEY_CHECKS=1;