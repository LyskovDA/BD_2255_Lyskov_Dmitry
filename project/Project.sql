CREATE TABLE employee(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
surname varchar(255) NOT NULL,
middle_name varchar(255) ,
mail varchar(255) NOT NULL UNIQUE,
phone varchar(12) NOT NULL UNIQUE,
schedule_works_id integer REFERENCES schedule_works (id),
start_work timestamp(0) NOT NULL,
finish_work timestamp(0)
)

CREATE TABLE schedule_works(
id serial PRIMARY KEY UNIQUE,
start timestamp(0) NOT NULL,
finish timestamp(0)
)

CREATE TABLE unit(
id serial PRIMARY KEY UNIQUE,
unit_name VARCHAR(255)
)

CREATE TABLE supplier(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
city varchar(255) NOT NULL,
street varchar(255) NOT NULL,
house varchar(20) NOT NULL,
coordinates varchar(1000) NOT NULL,
phone varchar(12) NOT NULL UNIQUE,
mail varchar(255) NOT NULL UNIQUE,
storage_product_id INTEGER REFERENCES storage_product(id)
)

CREATE TABLE product_sale(
id serial PRIMARY KEY UNIQUE,
storage_product_id INTEGER REFERENCES storage_product(id),
price INTEGER,
recipient_id INTEGER REFERENCES recipient(id),
employee_consumption_id INTEGER REFERENCES employee(id)
)

CREATE TABLE product_arrival(
id serial PRIMARY KEY UNIQUE,
storage_product_id INTEGER REFERENCES storage_product(id),
price INTEGER,
supplier_id INTEGER REFERENCES recipient(id),
employee_arrival_id INTEGER REFERENCES employee(id)
)


CREATE TABLE recipient(
id serial PRIMARY KEY UNIQUE,
name VARCHAR(255),
surname VARCHAR(255),
adress VARCHAR(255),
phone VARCHAR(255),
)

CREATE TABLE storage_product(
id serial PRIMARY KEY UNIQUE,
country_of_production VARCHAR(255),
name_product VARCHAR(255),
start_of_storage timestamp(0) NOT NULL,
finish_of_storage timestamp(0),
warehouse_id INTEGER REFERENCES warehouse(id),
unit_id INTEGER REFERENCES unit(id)
)



INSERT INTO schedule_works(start, finish) VALUES

INSERT INTO employee(name, surname, middle_name, mail, phone,schedule_works_id, start_work, finish_work) VALUES

INSERT INTO storage_product(country_of_production,name_product, start_of_storage, finish_of_storage) VALUES

INSERT INTO supplier(name, city, street, house, coordinates, phone, mail, storage_product_id) VALUES

INSERT INTO recipient(name, surname, adress, phone) VALUES

INSERT INTO product_arrival(storage_product_id, price, supplier_id, employee_arrival_id) VALUES

INSERT INTO product_sale(storage_product_id, price, recipient_id, employee_consumption_id) VALUES

INSERT INTO unit(unit_name) VALUES