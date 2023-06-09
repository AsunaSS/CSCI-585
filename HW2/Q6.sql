--DB Software used livesql.oracle.com

--DROP TABLE Uploads;
--DROP TABLE Channels;
--DROP TABLE Users;

--I created a table of users. Here user_ID is the primary key, and each user will have his/her name and address.
CREATE TABLE Users
(user_ID VARCHAR(30) NOT NULL,
u_name VARCHAR(30) NOT NULL,
u_address VARCHAR(100) NOT NULL,
PRIMARY KEY (user_ID));

--I created a table of Channels. Here channel_name is the primary key, and each channel will have its subscriber count
CREATE TABLE Channels
(channel_name VARCHAR(30) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
s_count INTEGER NOT NULL,
PRIMARY KEY (channel_name),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I created a table of Uploads.
CREATE TABLE Uploads
(v_url VARCHAR(50) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
channel_name VARCHAR(30) NOT NULL,
up_date DATE NOT NULL,
PRIMARY KEY (channel_name, user_ID, v_url),
FOREIGN KEY (channel_name) REFERENCES Channels(channel_name),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I inserted six users
INSERT INTO Users VALUES ('u1', 'A', '1966 Canis Heights Drive, US');
INSERT INTO Users VALUES ('u2', 'B', '1260 Locust Street, US');
INSERT INTO Users VALUES ('u3', 'C', '97 Peaceful Lane, UK');
INSERT INTO Users VALUES ('u4', 'D', '1618 Coolidge Street, US');
INSERT INTO Users VALUES ('u5', 'E', '552 Felosa Drive, UK');
INSERT INTO Users VALUES ('u6', 'F', '3314 Cambridge Place, US');

--I inserted six channels
INSERT INTO Channels VALUES ('Iron man', 'u1', 3000);
INSERT INTO Channels VALUES ('Spider man', 'u1', 9000);
INSERT INTO Channels VALUES ('Collection', 'u3', 12300);
INSERT INTO Channels VALUES ('DC Universe', 'u2', 22213);
INSERT INTO Channels VALUES ('Newest', 'u3', 4112);
INSERT INTO Channels VALUES ('BATMAN', 'u4', 10000);

--I inserted 20 upload records
INSERT INTO Uploads VALUES ('youtube.com/watch?v=kQb0DJZLhRM', 'u1', 'Iron man', DATE '2023-01-01');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=CajjpdHYneM', 'u1', 'Spider man',DATE '2023-01-06');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'u2', 'DC Universe',DATE '2023-01-04');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'u1', 'Iron man',DATE '2023-01-13');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=feu-aiRVpK4', 'u1', 'Spider man',DATE '2023-01-18');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=uXWtG55zDjo', 'u3', 'Collection',DATE '2023-01-05');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=t3FCDvo07tc', 'u3', 'Newest',DATE '2023-01-10');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=rs_t4MoIo-8', 'u4', 'BATMAN',DATE '2023-01-02');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=2FVfmlnrDW4', 'u2', 'DC Universe',DATE '2023-01-11');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=XAclWd8Yzis', 'u3', 'Collection',DATE '2023-01-16');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=Q2m3CW-22-U', 'u1', 'Iron man',DATE '2023-01-20');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=QkyEGdQ-pbE', 'u1', 'Spider man',DATE '2023-01-27');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=TX18vk__vUE', 'u2', 'DC Universe',DATE '2023-01-18');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=Uv2jtjtK5H4', 'u1', 'Iron man',DATE '2023-01-31');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=24134123413', 'u1', 'Spider man',DATE '2023-02-07');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=NVW0g_mphys', 'u3', 'Collection',DATE '2023-01-23');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=IKSUGeMzX_c', 'u3', 'Newest',DATE '2023-01-30');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=ikKm1SiBC5I', 'u4', 'BATMAN',DATE '2023-01-23');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=j7heZpuvu4U', 'u2', 'DC Universe',DATE '2023-01-25');
INSERT INTO Uploads VALUES ('youtube.com/watch?v=a47kMoYkES0', 'u3', 'Collection',DATE '2023-02-11');

SELECT u_name as username, channel_names, subscriber_count
FROM (Users
--Accumulate the number of subscribers of all channels belonging to a user by user_ID
INNER JOIN 
    (SELECT user_ID, channel_names, SUM(s_count) as subscriber_count
    --Internally merge all users, channels, and users who have uploaded at least one video per week, these three tables
    FROM (Channels 
    --Combine all channels of a user in one column
    INNER JOIN ((SELECT user_ID, LISTAGG(channel_name, ', ') as channel_names, u_name, u_address 
                  FROM Channels
                  --Filter out all users whose addresses are in the United States
                  INNER JOIN (SELECT * FROM Users WHERE u_address LIKE '%US%') USING (user_ID) 
                  GROUP BY user_ID, u_name, u_address)
                  INNER JOIN (SELECT user_ID
                              --Count the number of weeks each user uploaded at least one video in a month
                              FROM (SELECT DISTINCT user_ID, to_char(up_date, 'w') week_no
                                    FROM Uploads
                                    --Determine whether the upload time of a video is within the specified one-month interval
                                    WHERE up_date >= to_date('2023-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND up_date < to_date('2023-02-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss'))
                              GROUP BY user_ID
                              --Determine if the user has uploaded at least one video for more than four weeks, the user is eligible
                              HAVING count(*) >=4) USING (user_ID)) USING (user_ID))
    GROUP BY user_ID, channel_names) USING (user_ID));