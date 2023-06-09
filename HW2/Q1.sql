--DB Software used livesql.oracle.com

--DROP TABLE Sponsors;

--Frist I used CREATE TABLE to create a table of Sponsors. Here sponsor_ID is the primary key, and each sponsor will have its own name, phone number, address, and sponsor amount
CREATE TABLE Sponsors
(sponsor_ID VARCHAR(20) NOT NULL,
s_name VARCHAR(20) NOT NULL,
s_phone VARCHAR(20) NOT NULL,
s_address VARCHAR(30) NOT NULL,
s_amount INTEGER NOT NULL,
PRIMARY KEY (sponsor_ID));

--Then I inserted ten sponsors, some of them will have the same sponsor amount
INSERT INTO Sponsors VALUES ('00001', 'A', '213-746-2314', '1966 Canis Heights Drive', 60004);
INSERT INTO Sponsors VALUES ('00002', 'B', '229-938-9330', '1260 Locust Street', 60000);
INSERT INTO Sponsors VALUES ('00003', 'D', '216-533-6805', '97 Peaceful Lane', 1005);
INSERT INTO Sponsors VALUES ('00004', 'C', '406-896-3454', '1618 Coolidge Street', 10000);
INSERT INTO Sponsors VALUES ('00005', 'K', '323-983-8390', '552 Felosa Drive', 100000);
INSERT INTO Sponsors VALUES ('00006', 'L', '410-582-8074', '3314 Cambridge Place', 60000);
INSERT INTO Sponsors VALUES ('00007', 'Q', '516-849-1357', '4717 Westwood Avenue', 100000);
INSERT INTO Sponsors VALUES ('00008', 'WW', '405-929-9268', '160 Meadow Drive', 10);
INSERT INTO Sponsors VALUES ('00009', 'SAD', '330-380-5058', '4531 Derek Drive', 7000);
INSERT INTO Sponsors VALUES ('00010', 'ZXC', '516-826-9189', '1424 Westwood Avenue', 34567);

SELECT s_name as NAME, s_phone as PHONE, s_amount as SPONSOR_AMOUNT
FROM Sponsors
--I used subquery to select the highest sponsor amount in the table, then I used WHERE to match the records that sponsor amount equal to the max value.
WHERE s_amount=(SELECT MAX(s_amount) FROM Sponsors);
