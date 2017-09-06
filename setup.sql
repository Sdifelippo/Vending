DROP DATABASE IF EXISTS machinedb;
CREATE DATABASE machinedb;

\c machinedb

CREATE TABLE machine(
  machine_id SERIAL PRIMARY KEY,
  name TEXT,
  bank INTEGER
);


CREATE TABLE item(
  item_id SERIAL PRIMARY KEY,
  description TEXT,
  cost FLOAT,
  quantity INTEGER,
  machine_id INTEGER REFERENCES machine
);

CREATE TABLE purchase(
  purchase_id SERIAL PRIMARY KEY,
  purchase_time TIMESTAMPTZ,
  amount_taken FLOAT,
  change_given FLOAT,
  machine_id INTEGER REFERENCES machine,
  item_id INTEGER REFERENCES item
);

INSERT INTO machine(name, bank)
VALUES('Candy', 500),
('Snacks', 500),
('Beers', 500);

INSERT INTO item(description, cost, quantity, machine_id)
VALUES ('Skittles', 2.00, 10, (SELECT machine_id FROM machine WHERE name='Candy')),
('Peanuts', 2.00, 20, (SELECT machine_id FROM machine WHERE name='Candy')),
('Sour Patch', 1.00, 40, (SELECT machine_id FROM machine WHERE name='Candy')),
('Snickers', 1.00, 10, (SELECT machine_id FROM machine WHERE name='Candy')),
('Doritos', 4.00, 10, (SELECT machine_id FROM machine WHERE name='Snacks')),
('Chips', 4.00, 10, (SELECT machine_id FROM machine WHERE name='Snacks')),
('Cookies', 2.50, 30, (SELECT machine_id FROM machine WHERE name='Snacks')),
('Funyons', 4.00, 20, (SELECT machine_id FROM machine WHERE name='Snacks')),
('Purple Haze', 3.00, 40, (SELECT machine_id FROM machine WHERE name='Beers')),
('Blue Moon', 4.00, 20, (SELECT machine_id FROM machine WHERE name='Beers')),
('Corona', 4.00, 40, (SELECT machine_id FROM machine WHERE name='Beers')),
('Buds', 2.00, 4, (SELECT machine_id FROM machine WHERE name='Beers'));

INSERT INTO purchase(purchase_time, amount_taken, machine_id, item_id)
VALUES
('now', 20.00,(SELECT machine_id FROM machine WHERE name = 'Beers'), (SELECT item_id FROM item WHERE description ='Purple Haze'));


select * from machine;
select * from item;
select * from purchase;
