#!/bin/sh

files='/data/tweets/geoTwitter21-01-01.zip
/data/tweets/geoTwitter21-01-02.zip
/data/tweets/geoTwitter21-01-03.zip
/data/tweets/geoTwitter21-01-04.zip
/data/tweets/geoTwitter21-01-05.zip
/data/tweets/geoTwitter21-01-06.zip
/data/tweets/geoTwitter21-01-07.zip
/data/tweets/geoTwitter21-01-08.zip
/data/tweets/geoTwitter21-01-09.zip
/data/tweets/geoTwitter21-01-10.zip'


echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
echo "$files" | time parallel sh load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
echo "$files" | time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:7272/ --inputs
