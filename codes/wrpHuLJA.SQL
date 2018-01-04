CREATE TABLE IF NOT EXISTS workshops
(
       id integer PRIMARY KEY,
       location text NOT NULL,
       production_type text NOT NULL
);

CREATE TABLE machine
(
       id integer NOT NULL PRIMARY KEY,
       machine_id text NOT NULL,
       lifetime DATE NOT NULL,
       power_source VARCHAR(64) NOT NULL,
       workshop_id integer NOT NULL,
       FOREIGN KEY (workshop_id) REFERENCES workshops (id)
);



CREATE TABLE workers
(
       id INT NOT NULL PRIMARY KEY,
       workshop_id integer NOT NULL,
       employee_id integer NOT NULL,
       FOREIGN KEY (workshop_id) REFERENCES workshops(workshop_id) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE employees
(
       id INT NOT NULL PRIMARY KEY,
       full_name VARCHAR(64) NOT NULL,
       dob DATE NOT NULL
);

CREATE TABLE position
(
       id INT NOT NULL PRIMARY KEY,
       name VARCHAR(64) NOT NULL,
       employee_id integer NOT NULL,
       FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE speciality
(
       id INT NOT NULL PRIMARY KEY,
       name VARCHAR(64) NOT NULL,
       field_of_activity VARCHAR(64) NOT NULL,
       employee_id integer NOT NULL,
       FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE products
(
       id INT NOT NULL PRIMARY KEY,
       name VARCHAR(64) NOT NULL,
       target_audience VARCHAR(64) NOT NULL
);

CREATE TABLE produced
(
       produced_at DATE NOT NULL PRIMARY KEY,
       price VARCHAR(64) NOT NULL,
       speciality_id integer NOT NULL,
       workshop_id integer NOT NULL,
       product_id integer NOT NULL,
       FOREIGN KEY (workshop_id) REFERENCES workshop(workshop_id) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY (speciality_id) REFERENCES speciality(speciality_id) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO employees (id, full_name, dob) VALUES (1, "maksim marcynkevich", date("1488-12-12"));
INSERT INTO employees (id, full_name, dob) VALUES (2, "pavel belyakov1", date("1983-11-15"));
INSERT INTO employees (id, full_name, dob) VALUES (3, "andrew horemyka", date());

INSERT INTO position (id, name, employee_id) VALUES (1, "main engineer", 1);
INSERT INTO position (id, name, employee_id) VALUES (2, "cleaner", 2);
INSERT INTO position (id, name, employee_id) VALUES (3, "manager", 3);

INSERT INTO speciality (id, name, field_of_activity, employee_id) VALUES (1, "project management", "software", 3);
INSERT INTO speciality (id, name, field_of_activity, employee_id) VALUES (2, "workshop cleaner", "cleaning", 2);
INSERT INTO speciality (id, name, field_of_activity, employee_id) VALUES (2, "cpu development", "digital electronics", 1);
INSERT INTO speciality (id, name, field_of_activity, employee_id) VALUES (3, "cpu development", "digital electronics", 1);

INSERT INTO workers (id, workshop_id, employee_id) VALUES (1, 1, 2);
INSERT INTO workers (id, workshop_id, employee_id) VALUES (1, 1, 1);
INSERT INTO workers (id, workshop_id, employee_id) VALUES (2, 2, 1);
INSERT INTO workers (id, workshop_id, employee_id) VALUES (3, 3, 2);
INSERT INTO workers (id, workshop_id, employee_id) VALUES (4, 2, 3);

INSERT INTO workshops (id, location, production_type) VALUES (1, "california", "cpu");
INSERT INTO workshops (id, location, production_type) VALUES (2, "honkong", "electrocars");
INSERT INTO workshops (id, location, production_type) VALUES (3, "london", "ICs");


INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 1, 1, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 2, 2, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 3, 2, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 3, 3, 2);
INSERT INTO produced (produced_at, price, workshop_id, product_id, speciality_id) VALUES (datetime(), "555", 3, 3, 3);

-- SELECT employees.full_name, workshops.location, workshops.production_type from workers
-- inner join employees on employees.id = workers.employee_id
-- inner join workshops on workshops.id = workers.workshop_id
-- wherpe workshops.location like 'california' order by employees.full_name;


-- SELECT distinct produced_at, products.name, workshops.location, price from produced
-- inner join products on products.id = produced.product_id
-- inner join workshops on workshops.id = produced.workshop_id
-- order by produced_at;

-- SELECT employees.full_name, workshops.production_type, speciality.name from produced
-- inner join workshops on workshops.id = produced.workshop_id
-- inner join speciality on speciality.id = produced.speciality_id
-- inner join employees on employees.id = speciality.employee_id;

----------------------------------------------------------------------


-- select employees.full_name, avg(price) from produced
-- inner join speciality on produced.speciality_id = speciality.id
-- inner join employees on speciality.employee_id = employees.id
-- where employees.dob < '2000-07-01:00:00:00'
-- group by employees.full_name;

-- select workshops.location, workshops.production_type, count(workers.id) from workers
-- inner join workshops on workers.workshop_id = workshops.id
-- group by location, production_type
-- order by count(workers.id) desc;

select products.name, employees.full_name  from produced
inner join products on produced.product_id = products.id
inner join speciality on produced.speciality_id = speciality.id
inner join employees on speciality.employee_id = employees.id
inner join position on employees.id = position.employee_id
where position.name like 'cleaner';