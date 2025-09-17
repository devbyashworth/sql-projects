
-- Create tables
DROP TABLE IF EXISTS properties, elements, types;

CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(30) NOT NULL
);

CREATE TABLE elements (
  atomic_number SERIAL PRIMARY KEY,
  symbol VARCHAR(2) NOT NULL UNIQUE,
  name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE properties (
  property_id SERIAL PRIMARY KEY,
  atomic_number INT NOT NULL,
  type_id INT NOT NULL,
  atomic_mass REAL NOT NULL,
  melting_point_celsius REAL,
  boiling_point_celsius REAL,
  FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number),
  FOREIGN KEY (type_id) REFERENCES types(type_id)
);

-- Insert types
INSERT INTO types(type) VALUES 
('metal'), 
('nonmetal'), 
('metalloid');

-- Insert elements and properties
INSERT INTO elements(atomic_number, symbol, name) VALUES 
(1, 'H', 'Hydrogen'),
(2, 'He', 'Helium'),
(3, 'Li', 'Lithium'),
(4, 'Be', 'Beryllium'),
(5, 'B', 'Boron'),
(6, 'C', 'Carbon'),
(7, 'N', 'Nitrogen'),
(8, 'O', 'Oxygen'),
(9, 'F', 'Fluorine'),
(10, 'Ne', 'Neon');

INSERT INTO properties(atomic_number, type_id, atomic_mass, melting_point_celsius, boiling_point_celsius) VALUES
(1, 2, 1.008, -259.1, -252.9),
(2, 2, 4.0026, -272.2, -268.9),
(3, 1, 6.94, 180.5, 1342),
(4, 1, 9.0122, 1287, 2469),
(5, 3, 10.81, 2075, 4000),
(6, 2, 12.011, 3550, 4827),
(7, 2, 14.007, -210.1, -195.8),
(8, 2, 15.999, -218.8, -183.0),
(9, 2, 18.998, -219.6, -188.1),
(10, 2, 20.180, -248.6, -246.1);
