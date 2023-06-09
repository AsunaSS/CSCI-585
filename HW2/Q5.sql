--DB Software used livesql.oracle.com

--DROP TABLE Records;
--DROP TABLE Videos;
--DROP TABLE Channels;
--DROP TABLE Users;

--I created a table of users. Here user_ID is the primary key, and each user will have his/her name and age.
CREATE TABLE Users
(user_ID VARCHAR(30) NOT NULL,
u_name VARCHAR(30) NOT NULL,
u_age INTEGER NOT NULL,
PRIMARY KEY (user_ID));

--I created a table of Channels. Here channel_name is the primary key, and each channel will have a foregin key from Users as their owner.
CREATE TABLE Channels
(channel_name VARCHAR(30) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
PRIMARY KEY (channel_name),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I used CREATE TABLE to create a table of Videos. Here v_URL is the primary key, and each video will have its own title, name of the channel it belongs to
CREATE TABLE Videos
(v_URL VARCHAR(50) NOT NULL,
v_title VARCHAR(30) NOT NULL,
channel_name VARCHAR(30) NOT NULL,
c_num INTEGER NOT NULL,
PRIMARY KEY (v_URL),
FOREIGN KEY (channel_name) REFERENCES Channels(channel_name));

--I used CREATE TABLE to create a table of Records. It will record which user saw which video
CREATE TABLE Records
(v_URL VARCHAR(50) NOT NULL,
user_ID VARCHAR(30) NOT NULL,
PRIMARY KEY (v_URL, user_ID),
FOREIGN KEY (v_URL) REFERENCES Videos(v_URL),
FOREIGN KEY (user_ID) REFERENCES Users(user_ID));

--I inserted eight users
INSERT INTO Users VALUES ('u1', 'Taylor Swift', 33);
INSERT INTO Users VALUES ('u2', 'Joe Alwyn', 32);
INSERT INTO Users VALUES ('u3', 'Jack Antonoff', 38);
INSERT INTO Users VALUES ('u4', 'QQ', 12);
INSERT INTO Users VALUES ('u5', 'Andie MacDowell', 64);
INSERT INTO Users VALUES ('u6', 'Harold Allen Ramis', 80);
INSERT INTO Users VALUES ('u7', 'Emma Pasarow', 27);
INSERT INTO Users VALUES ('u8', 'KK', 60);

--I inserted four channels
INSERT INTO Channels VALUES ('Song1', 'u1');
INSERT INTO Channels VALUES ('Song2', 'u1');
INSERT INTO Channels VALUES ('Song3', 'u1');
INSERT INTO Channels VALUES ('DC Universe', 'u2');

--I inserted ten videos, some of them will have the same channel name.
--I created two videos BOTH HAVE HIGHEST COMMENTS (they are D and C)!
INSERT INTO Videos VALUES ('youtube.com/watch?v=kQb0DJZLhRM', 'A', 'Song1', 9999);
INSERT INTO Videos VALUES ('youtube.com/watch?v=CajjpdHYneM', 'L', 'Song2', 10000);
INSERT INTO Videos VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'D', 'Song1', 99999);
INSERT INTO Videos VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'C', 'Song2', 99999);
INSERT INTO Videos VALUES ('youtube.com/watch?v=feu-aiRVpK4', 'K', 'Song1', 44231);
INSERT INTO Videos VALUES ('youtube.com/watch?v=uXWtG55zDjo', 'B', 'Song3', 89701);
INSERT INTO Videos VALUES ('youtube.com/watch?v=t3FCDvo07tc', 'Q', 'Song3', 12);
INSERT INTO Videos VALUES ('youtube.com/watch?v=rs_t4MoIo-8', 'W', 'Song2', 11123);
INSERT INTO Videos VALUES ('youtube.com/watch?v=2FVfmlnrDW4', 'S', 'DC Universe', 19012312);
INSERT INTO Videos VALUES ('youtube.com/watch?v=XAclWd8Yzis', 'Z', 'DC Universe', 12412341);

--I inserted 13 records
INSERT INTO Records VALUES ('youtube.com/watch?v=kQb0DJZLhRM', 'u2');
INSERT INTO Records VALUES ('youtube.com/watch?v=CajjpdHYneM', 'u2');
INSERT INTO Records VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'u5');
INSERT INTO Records VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'u7');
INSERT INTO Records VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'u3');
INSERT INTO Records VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'u6');
INSERT INTO Records VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'u4');
INSERT INTO Records VALUES ('youtube.com/watch?v=feu-aiRVpK4', 'u4');
INSERT INTO Records VALUES ('youtube.com/watch?v=uXWtG55zDjo', 'u3');
INSERT INTO Records VALUES ('youtube.com/watch?v=t3FCDvo07tc', 'u3');
INSERT INTO Records VALUES ('youtube.com/watch?v=rs_t4MoIo-8', 'u8');
INSERT INTO Records VALUES ('youtube.com/watch?v=2FVfmlnrDW4', 'u1');
INSERT INTO Records VALUES ('youtube.com/watch?v=XAclWd8Yzis', 'u1');

SELECT v_title, min(u_age) as min_age, max(u_age) as max_age
--Merge records, users, and (the information about the video with the highest comments)
FROM (Records
INNER JOIN (SELECT v_url, v_title
            --Merge Videos, Channels and Users these three tables
            FROM (SELECT v_url, v_title, c_num
                  FROM((Videos
                        INNER JOIN Channels USING (channel_name))
                        INNER JOIN Users USING (user_ID))
                  --Find the videos whose creator is Taylor Swift 
                  WHERE u_name = 'Taylor Swift') T
                  --Sort the results by desc
                  --ORDER BY c_num DESC)
            --Get the video/s with the highest comments
            WHERE T.c_num = (SELECT max(c_num) FROM (SELECT v_url, v_title, c_num
                                                    --Here I merge Videos, Channels and Users these three tables again to make it only contains the videos from Taylor Swift to get the value of the highest comments
                                                    FROM((Videos
                                                          INNER JOIN Channels USING (channel_name))
                                                          INNER JOIN Users USING (user_ID))
                                                    WHERE u_name = 'Taylor Swift'))) USING (v_url)
INNER JOIN Users USING (user_ID))
GROUP BY v_title;
--I created two videos BOTH HAVE HIGHEST COMMENTS, so the output should have two rows!