SELECT tag, COUNT(*) AS count
FROM (
    SELECT data->>'id' AS id_tweets, '#' || (jsonb_array_elements(data->'entities'->'hashtags' || coalesce(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') AS tag
    FROM tweets_jsonb
    WHERE to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
        AND data->>'lang' = 'en'
) AS t1
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

