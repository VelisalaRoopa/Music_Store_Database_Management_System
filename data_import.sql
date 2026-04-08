create database music_store;
use music_store;


CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);


CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
);


CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);


CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);


-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);


-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

select * from track;
TRUNCATE TABLE track;


SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'C:\Users\yaswa\OneDrive\Desktop\music store data\track.csv'
INTO TABLE Track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE  'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv'
INTO TABLE  track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price);

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE InvoiceLine;
TRUNCATE TABLE Track;

SET FOREIGN_KEY_CHECKS = 1;
select * from track;



SELECT COUNT(*) AS Genre_Count FROM Genre;
SELECT COUNT(*) AS MediaType_Count FROM MediaType;
SELECT COUNT(*) AS Employee_Count FROM Employee;
select * from employee;
truncate table employee;
truncate table employee;
SELECT COUNT(*) AS Customer_Count FROM Customer;
SELECT COUNT(*) AS Artist_Count FROM Artist;
SELECT COUNT(*) AS Album_Count FROM Album;
SELECT COUNT(*) AS Track_Count FROM Track;
SELECT COUNT(*) AS Invoice_Count FROM Invoice;
SELECT COUNT(*) AS InvoiceLine_Count FROM InvoiceLine;
SELECT COUNT(*) AS Playlist_Count FROM Playlist;
SELECT COUNT(*) AS PlaylistTrack_Count FROM PlaylistTrack;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_id, last_name, first_name, title, @reports_to, levels, birthdate, hire_date, address, city, state, country, postal_code, phone, fax, email)
SET reports_to = NULLIF(@reports_to, '');


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_id, last_name, first_name, title, @reports_to, levels, birthdate, hire_date, address, city, state, country, postal_code, phone, fax, email)
SET reports_to = NULLIF(@reports_to, '');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_id, last_name, first_name, title, @reports_to, levels, @birthdate, @hire_date, address, city, state, country, postal_code, phone, fax, email)
SET 
reports_to = NULLIF(@reports_to, ''),
birthdate = STR_TO_DATE(@birthdate, '%d-%m-%Y'),
hire_date = STR_TO_DATE(@hire_date, '%d-%m-%Y');

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE Customer;
TRUNCATE TABLE Employee;

SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_id, last_name, first_name, title, @reports_to, levels, @birthdate, @hire_date, address, city, state, country, postal_code, phone, fax, email)
SET 
reports_to = NULLIF(@reports_to, ''),
birthdate = STR_TO_DATE(@birthdate, '%d-%m-%Y'),
hire_date = STR_TO_DATE(@hire_date, '%d-%m-%Y');


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;