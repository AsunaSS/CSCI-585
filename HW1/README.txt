// Name: Chaoyu Li
// USC NetID: 6641732094
// CSCI-585 HW1
// Spring 2023

Table Details And Assumptions:

1. USER
PK: USER_ID(user's ID)
Required Attribute: USER_NAME(user's full name), USER_EMAIL(student's email), USER_TYPE(user's type(CREATOR or CONSUMER or both))
Optional Attribute: USER_AGE(user's age), USER_ADDRESS(user's address)

- A user must submit their name and email to sign up. After signing up, the user will get a unique user ID. A user can be a creator or a consumer or both and it will be recorded in the attribute USER_TYPE. The user’s age and address are not required but they can fill them in their profile.

- Because a user be a creator or a consumer or both, it is an overlap and complete constraint, and USER_TYPE should determine it. CREATOR and CONSUMER should be two subtypes of USER.

2. CHANNEL
PK: CHANNEL_NAME(channel's name), USER_ID(user's ID, foreign key from USER)
Required Attribute: SUB_NUM(channel's subscription count), CREATED_DATE(details of when the channel was created)

- A channel has relationships with both creators and consumers. A channel should be created by only one creator but it can be accessed or subscribed to by many consumers. I assumed the relationship between creator and channels is 1:M and the relationship between consumers and channels is M:N. And channel's details(attributes) should be seen by any user(creators or consumers).

3. CREATOR
PK: USER_ID(user's ID, foreign key from USER)
Required Attribute: CHANNEL_NAME(channel's name, foreign key from CHANNEL), REVENUES(creator's total revenues)

- A creator can create many channel and access all attributes from his/her channels.

4. CONSUMER
PK: USER_ID(user's ID, foreign key from USER)
Required Attribute: CHANNEL_NAME(channel's name, foreign key from CHANNEL), CONSUMPTION(consumer's total cost)

- A consumer can subscribe many channels. I used an associative entity SUBSCRIPTION to connect CONSUMER and CHANNEL.

5. SUBSCRIPTION
PK: USER_ID(user's ID, foreign key from USER), CHANNEL_NAME(channel's name, foreign key from CHANNEL)
Required Attribute: SUB_TYPE(subscription type, can be paid or free)

- SUBSCRIPTION is an associative entity SUBSCRIPTION to connect CONSUMER and CHANNEL. The relationship between CONSUMER and CHANNEL should be M:N. However, with SUBSCRIPTION, the relationship become two 1:M.

6. VIDEO
PK: V_URL(video's URL)
Required Attribute: V_TITLE(video's title), V_CATEGORY(video's category), USER_ID(ID of video's uploader, foreign key from USER), V_TYPE(video's type(can be informational videos, entertainment videos, etc))
Optional Attribute: V_THUMB(video's thumbnails), V_DURATION(video's duration), V_DESC(video's description), V_UPLOADDATE(video's upload date), V_UPLOADTIME(video's upload time)

- A video can be identified by its URL. I assumed that all metadata from YouTube’s transcoding server is stored in the VIDEO entity.

- A video should be uploaded by only one user, but a user can upload many videos.

- I assumed that a video can be only categorized into one channel, but a channel can contain many videos. And videos can be there even if they are not categorized into any channel. So the relationship between VIDEO and CHANNEL is a weak relationship.

- I assumed that video's type is different from the video's category because a video can have many categories at the same time. For example, a video can be categorized as action, live, etc. I designed V_TYPE here to categorize a video into informational videos, entertainment videos, etc.

- Because videos can be categorized into informational videos, entertainment videos, etc, it is a disjoint and partial constraint, and V_TYPE should determine it. INFORMATIONAL and ENTERTAINMENT should be two subtypes of VIDEO.

7. INFORMATIONAL
PK: V_URL(video's URL, foreign key from VIDEO), KEYWORDS(informational video's keywords)

8. ENTERTAINMENT
PK: V_URL(video's URL, foreign key from VIDEO), TAGS(entertainment video's tags)

9. STATISTICS
PK: USER_ID(user's ID, foreign key from USER), V_URL(video's URL, foreign key from VIDEO)
Required Attribute: LIKE_NUM(number of likes), DISLIKE_NUM(number of dislikes), VIEW_NUM(number of views), SHARE_NUM(number of shares), COMMENT_NUM(number of comments), POPULARITY(video's popularity)

- I assumed a statistics should depend on users and videos to exist, otherwise it is meaningless, because the purpose of statistics is to finally calculate the creator's revenue. Therefore, I set both the relationship between STATISTICS and CREATOR and the relationship between STATISTICS and VIDEO to be strong relationships.

- I set the relationship between STATISTICS and VIDEO to be 1:1 because a video should only have one statistics.

10. COMMENT
PK: USER_ID(user's ID, foreign key from USER), V_URL(video's URL, foreign key from VIDEO)
Required Attribute: C_TEXT(comment text), CLIKE_NUM(number of likes), C_SENTIMENT(comment's sentiment), C_DATE(the details of when it was commented)

- I assumed a comment should depend on users and videos to exist, otherwise it is meaningless, because you need a user to write the comment and you also need a video to comment. Therefore, I set both the relationship between COMMENT and USER and the relationship between COMMENT and VIDEO to be strong relationships.

11. SPONSOR
PK: SPONSOR_ID(sponsor's ID)
Required Attribute: S_NAME(sponsor's name), S_PHONE(sponsor's phone number), S_ADDRESS(sponsor's address), S_NUM(the amount sponsored)

- Sponsors should not have relationships with consumers, they should only have relationships with creators.

- Both the relationship between SPONSOR and CREATOR and the relationship between COMMENT and VIDEO should be weak relationships.

- I assumed that a creator can cooperate with many sponsors, and a sponsor can cooperate with many creators(M:N).

- I assumed that a video can contain many sponsors, and a sponsor can be contained in many videos(M:N), though it will make the video look bad.