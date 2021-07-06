# **NO SQL exercises**
## **Robo 3T -> Document oriented database systems**

## Solutions
    1. db.tweets.find('source' : 'web').count()
    2. db.tweets.find({'entities.hashtags.text' : 'javascript'}).count()
    3. db.tweets.find({'user.followers_count' :{$gt : 100}}).count()
    4. db.tweets.find({'user.time_zone' : 'Lisbon'}).count()
    5. db.tweets.distinct('user.time_zone')
    6. db.tweets.findOne({'entities.user_mentions' : {$ne : []}})
    7. db.tweets.find({'entities.user_mentions' : {$ne : []}}).count()
    8. db.tweets.find({'entities.user_mentions' : {$size : 3}}).count()
    9. db.tweets.find({'entities.user_mentions' : {$size : 3}}, {'entities. hash_tags' : { $size : 2}}).count()
    10. db.tweets.find({'text' : {$regex : 'Cristiano Ronaldo'}}).count()
    11. db.tweets.aggregate([
        {$ group:{_id: '$ entities.hashtags.text', tweets: {$sum : 1}}},
        {$ sort:{tweets: -1}}])
    12. db.tweets.find().limit(100).sort({'user.friends_count' : 1})
    13. db.tweets.aggregate([
        {$ group:{_id: '$ user.time_zone', tweets: {$sum : 1}}},
        {$ match:{tweets: {$gt : 100}}}])
    14. db.tweets.aggregate([
        { $ group:{_id: '$ user.screen_name', tweets: {$sum : 1}}},
        { $ match:{tweets: {$gt : 7}}}])
    15. db.tweets.aggregate([
        {$ project:{item:1, NumHashtags: {$ size: '$entities.hashtags'}}},
        {$ sort:{NumHashtags: -1}}])