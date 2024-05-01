select tag, count(*) as count
from (
	select distinct  data->>'id' as id_tweets, '#' || (jsonb_array_elements(data->'entities'->'hashtags' || coalesce(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') as tag 
	from tweets_jsonb 
	where data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"' or data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"')t1 
group by tag
order by count desc, tag 
limit 1000;
