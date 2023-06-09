
--DB Software used livesql.oracle.com

--DROP TABLE Comments;
--DROP TABLE Videos;

--I used CREATE TABLE to create a table of Videos. Here v_URL is the primary key, and each video will have its own keywords
CREATE TABLE Videos
(v_URL VARCHAR(50) NOT NULL,
keywords VARCHAR(100) NOT NULL,
PRIMARY KEY (v_URL));

--I used CREATE TABLE to create a table of Comments. Here v_URL and comment_ID are primary keys, and each comment will have its own sentiment, it's a float value
CREATE TABLE Comments
(v_URL VARCHAR(50) NOT NULL,
comment_ID VARCHAR(50) NOT NULL,
sentiment FLOAT NOT NULL,
PRIMARY KEY (v_URL, comment_ID),
FOREIGN KEY (v_URL) REFERENCES Videos(v_URL));

--I inserted ten videos, some of them will have multiple keywords
INSERT INTO Videos VALUES ('youtube.com/watch?v=kQb0DJZLhRM', 'Iron man,Spider man,Collection');
INSERT INTO Videos VALUES ('youtube.com/watch?v=CajjpdHYneM', 'Spider man');
INSERT INTO Videos VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', 'DC Universe,Collection');
INSERT INTO Videos VALUES ('youtube.com/watch?v=dWzM90u9GUU', 'Iron man,Spider man');
INSERT INTO Videos VALUES ('youtube.com/watch?v=feu-aiRVpK4', 'Spider man,Newest');
INSERT INTO Videos VALUES ('youtube.com/watch?v=uXWtG55zDjo', 'Collection');
INSERT INTO Videos VALUES ('youtube.com/watch?v=t3FCDvo07tc', 'DC Universe,Collection,Newest');
INSERT INTO Videos VALUES ('youtube.com/watch?v=rs_t4MoIo-8', 'BATMAN,DC Universe');
INSERT INTO Videos VALUES ('youtube.com/watch?v=2FVfmlnrDW4', 'DC Universe');
INSERT INTO Videos VALUES ('youtube.com/watch?v=XAclWd8Yzis', 'Collection,BATMAN,Iron man,Spider man');

--I inserted 20 comments each video has two comments
INSERT INTO Comments VALUES ('youtube.com/watch?v=kQb0DJZLhRM', '4599259066', 47.86);
INSERT INTO Comments VALUES ('youtube.com/watch?v=CajjpdHYneM', '7127562285', 50.59);
INSERT INTO Comments VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', '6231458150', 6.33);
INSERT INTO Comments VALUES ('youtube.com/watch?v=dWzM90u9GUU', '2725349002', 38.69);
INSERT INTO Comments VALUES ('youtube.com/watch?v=feu-aiRVpK4', '6366270293', 13.51);
INSERT INTO Comments VALUES ('youtube.com/watch?v=uXWtG55zDjo', '6947015923', 26.98);
INSERT INTO Comments VALUES ('youtube.com/watch?v=t3FCDvo07tc', '2743777575', 1.97);
INSERT INTO Comments VALUES ('youtube.com/watch?v=rs_t4MoIo-8', '7397117535', 47.99);
INSERT INTO Comments VALUES ('youtube.com/watch?v=2FVfmlnrDW4', '9086183701', 5.48);
INSERT INTO Comments VALUES ('youtube.com/watch?v=XAclWd8Yzis', '4057126547', 42.85);
INSERT INTO Comments VALUES ('youtube.com/watch?v=kQb0DJZLhRM', '3669236875', 45.3);
INSERT INTO Comments VALUES ('youtube.com/watch?v=CajjpdHYneM', '8278053967', 77.77);
INSERT INTO Comments VALUES ('youtube.com/watch?v=ZYV5X2rq-F0', '7887140310', 42.36);
INSERT INTO Comments VALUES ('youtube.com/watch?v=dWzM90u9GUU', '2622554739', 91.74);
INSERT INTO Comments VALUES ('youtube.com/watch?v=feu-aiRVpK4', '5449931294', 70.11);
INSERT INTO Comments VALUES ('youtube.com/watch?v=uXWtG55zDjo', '2509517730', 33.05);
INSERT INTO Comments VALUES ('youtube.com/watch?v=t3FCDvo07tc', '8281228992', 92.69);
INSERT INTO Comments VALUES ('youtube.com/watch?v=rs_t4MoIo-8', '4121105172', 8.19);
INSERT INTO Comments VALUES ('youtube.com/watch?v=2FVfmlnrDW4', '3081003523', 23.41);
INSERT INTO Comments VALUES ('youtube.com/watch?v=XAclWd8Yzis', '0346315827', 75.17);

--Find all levels in keywords (a comma means a level)
WITH NT AS (
     SELECT LEVEL n FROM DUAL CONNECT BY LEVEL <= 100
)

SELECT keyword, AVG(sentiment) as avg_sentiment
FROM (Comments 
--Split keywords to many keyword according to the comma, then merge with Comments table
INNER JOIN (SELECT Videos.v_URL, regexp_substr(Videos.keywords, '[^,]+', 1, NT.n,'i') as keyword
            FROM Videos, NT
            WHERE NT.n <= LENGTH(Videos.keywords) - LENGTH(REGEXP_REPLACE(Videos.keywords, ',', '')) + 1) USING (v_URL))
--Group by each keyword
GROUP BY keyword
--Sort them in desc way
ORDER BY avg_sentiment DESC;