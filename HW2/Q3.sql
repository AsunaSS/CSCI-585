--DB Software used livesql.oracle.com

--DROP TABLE Channels;
--DROP TABLE Users;

--I created a table of users. Here user_ID is the primary key, and each user will have his name and email.
CREATE TABLE Users
(user_ID VARCHAR(30) NOT NULL,
u_email VARCHAR(30) NOT NULL,
u_name VARCHAR(30) NOT NULL,
PRIMARY KEY (user_ID));

--I created a table of Channels. Here channel_name is the primary key, and each channel will have a foregin key from Users as their owner.
CREATE TABLE Channels
(channel_name VARCHAR(30) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
creation_date VARCHAR(20) NOT NULL,
s_count INTEGER NOT NULL,
PRIMARY KEY (channel_name),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I inserted six users
INSERT INTO Users VALUES ('u1', 'tracteur@chaocosen.com', 'A');
INSERT INTO Users VALUES ('u2', 'thaisasud@kubét.vn', 'B');
INSERT INTO Users VALUES ('u3', 'gingillo@alione.top', 'C');
INSERT INTO Users VALUES ('u4', 'marilina1@suzy.email', 'D');
INSERT INTO Users VALUES ('u5', 'zzxsa@alione.top', 'E');
INSERT INTO Users VALUES ('u6', '1sxzcx@suzy.email', 'F');

--I inserted ten channels
INSERT INTO Channels VALUES ('Iron man', 'u1', '01.01.2023', 20);
INSERT INTO Channels VALUES ('Spider man', 'u1', '05.08.2022', 999);
INSERT INTO Channels VALUES ('Collection', 'u3', '01.01.2022', 12);
INSERT INTO Channels VALUES ('DC Universe', 'u2', '01.01.2023', 223);
INSERT INTO Channels VALUES ('Newest', 'u3', '01.01.2023', 99);
INSERT INTO Channels VALUES ('BATMAN', 'u4', '01.01.2023', 51);
INSERT INTO Channels VALUES ('OLDEST', 'u3', '12.12.2022', 232412);
INSERT INTO Channels VALUES ('XXX', 'u1', '01.01.2023', 81);
INSERT INTO Channels VALUES ('YYY', 'u4', '01.01.2023', 99);
INSERT INTO Channels VALUES ('ZZZZ', 'u3', '12.12.2022', 1234);

SELECT u_name as username, u_email as email, channel_names, subscriber_count
--I used LISTAGG to group the channels created in 01.01.2023 to a string, and I used SUM to add all their subcriber count
FROM ((SELECT user_ID, LISTAGG(channel_name, ', ') as channel_names, SUM(s_count) as subscriber_count
      FROM Channels
      --Find all channels created in 01.01.2023
      WHERE creation_date = '01.01.2023'
      --Group the result by user_ID to make user unique
      GROUP BY user_ID) 
--I used INNER JOIN to join users' information such as email
INNER JOIN Users USING (user_ID))
--Find all results match that subscriber_count greater than 100
WHERE subscriber_count > 100;

