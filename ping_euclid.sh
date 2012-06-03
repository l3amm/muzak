
while :
do
	/bin/bash -l -c 'cd /Users/winky/muzak && RAILS_ENV=development bundle exec rake shoppers:get_detected_shoppers --silent'
	echo "stuff"
	sleep 5
done