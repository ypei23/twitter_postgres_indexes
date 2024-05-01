create index on tweets_jsonb using gin((data->'entities'->'hashtags')); 
create index on tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags')); 
create index on tweets_jsonb using gin(to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text'))) where (data->>'lang'='en');
create index on tweets_jsonb((data->>'lang'));
