DROP DATABASE IF EXISTS machinedb;
CREATE DATABASE machinedb;

\c machinesdb

CREATE TABLE machines(
  machines_id SERIAL PRIMARY KEY,
  location TEXT,
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

INSERT INTO machines(bank, location)
VALUES(350.00, 'Entrance'),
(250.75, 'Break Area'),
(210.25, 'Beer Thirty');

INSERT INTO item(cost, location, amount, machine_id)
VALUES ('Skittles', 1.75, 10, (SELECT machines_id FROM machines WHERE location='Entrance')),
('Peanuts', 2.00, 20, (SELECT machines_id FROM machines WHERE location='Entrance')),
('Sour Patch', 1.00, 40, (SELECT machines_id FROM machines WHERE location='Entrance')),
('Snickers', 1.00, 10, (SELECT machines_id FROM machines WHERE location='Entrance')),
('Doritos', 1.50, 10, (SELECT machines_id FROM machines WHERE location='Break Area')),
('Jerky', 2.00, 10, (SELECT machines_id FROM machines WHERE location='Break Area')),
('Oreos', 1.75, 30, (SELECT machines_id FROM machines WHERE location='Break Area')),
('Funyons', 1.50.00, 20, (SELECT machines_id FROM machines WHERE location='Break Area')),
('Purple Haze', 3.50, 40, (SELECT machines_id FROM machines WHERE location='Beer Thirty')),
('Blue Moon', 4.00, 20, (SELECT machines_id FROM machines WHERE location='Beer Thirty')),
('Corona', 4.00, 40, (SELECT machines_id FROM machines WHERE location='Beer Thirty')),
('Buds', 8.50, 4, (SELECT machines_id FROM machines WHERE location='Beer Thirty'));

INSERT INTO purchase(purchase_time, amount_taken, machines_id, item_id)
VALUES
('now', 20.00,(SELECT machines_id FROM machines WHERE location = 'Beer Thirty'), (SELECT item_id FROM item WHERE description ='Purple Haze'), 3.50, 5.00),
('now', 20.00,(SELECT machines_id FROM machines WHERE location = 'Break Area '), (SELECT item_id FROM item WHERE description ='Corona'), 1.00, 0),
('now', 20.00,(SELECT machines_id FROM machines WHERE location = 'Entrance '), (SELECT item_id FROM item WHERE description ='Oreos'), 1.75, 3.00),

select * from machines;
select * from item;
select * from purchase;
