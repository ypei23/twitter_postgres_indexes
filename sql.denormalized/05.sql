select tag, count(*) as count 
from(
	data->>'id' as id_tweets, '#' || (jsonb_array_elements(data->'entities'->'hashtags' || coalesce(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') as tag 
	from tweets_jsonb 
	where to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english', 'coronavirus') and data->>'lang' = 'en') t1 
group by tag
order by count desc, tag
limit 1000;
