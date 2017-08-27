DROP DATABASE IF EXISTS machinedb;
CREATE DATABASE machinedb;

\c machinesdb

CREATE TABLE machines(
  machines_id SERIAL PRIMARY KEY,
  name TEXT,
  bank INTEGER
);


CREATE TABLE item(
  item_id SERIAL PRIMARY KEY,
  description TEXT,
  cost FLOAT,
  quantity INTEGER,
  machines_id INTEGER REFERENCES machines
);

CREATE TABLE purchase(
  purchase_id SERIAL PRIMARY KEY,
  purchase_time TIMESTAMPTZ,
  amount_taken FLOAT,
  change_given FLOAT,
  machines_id INTEGER REFERENCES machines,
  item_id INTEGER REFERENCES item
);

INSERT INTO machines(name, bank)
VALUES('getSnacks', 500),
('Snacks', 500),
('beerThirty', 500);

INSERT INTO item(description, cost, quantity, machines_id)
VALUES ('Skittles', 1.75, 10, (SELECT machines_id FROM machines WHERE name='getSnacks')),
('Peanuts', 2.00, 20, (SELECT machines_id FROM machines WHERE name='getSnacks')),
('Sour Patch', 1.00, 40, (SELECT machines_id FROM machines WHERE name='getSnacks')),
('Snickers', 1.00, 10, (SELECT machines_id FROM machines WHERE name='getSnacks')),
('Doritos', 1.50, 10, (SELECT machines_id FROM machines WHERE name='Snacks')),
('Jerky', 2.00, 10, (SELECT machines_id FROM machines WHERE name='Snacks')),
('Oreos', 1.75, 30, (SELECT machines_id FROM machines WHERE name='Snacks')),
('Funyons', 1.50.00, 20, (SELECT machines_id FROM machines WHERE name='Snacks')),
('Purple Haze', 3.50, 40, (SELECT machines_id FROM machines WHERE name='beerThirty')),
('Blue Moon', 4.00, 20, (SELECT machines_id FROM machines WHERE name='beerThirty')),
('Corona', 4.00, 40, (SELECT machines_id FROM machines WHERE name='beerThirty')),
('Buds', 8.50, 4, (SELECT machines_id FROM machines WHERE name='beerThirty'));

INSERT INTO purchase(purchase_time, amount_taken, machines_id, item_id)
VALUES
('now', 20.00,(SELECT machines_id FROM machines WHERE name = 'beerThirty'), (SELECT item_id FROM item WHERE description ='Purple Haze'));


select * from machines;
select * from item;
select * from purchase;
