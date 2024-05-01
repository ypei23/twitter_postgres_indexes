select lang, count(*) as count 
from (
	select  data->>'id' as id_tweets, data->>'lang' as lang 
	from tweets_jsonb 
	where data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"' or data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"' 
)t1 
group by lang
order by count desc, lang;
