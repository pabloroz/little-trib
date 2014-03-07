setup:
	echo APP_KEY=$$(basename $$(pwd)) >> env.sh
	echo APP_SECRET=$$(make secret | grep -v 'ruby') >> env.sh
	echo REDIS_URL=redis://127.0.0.1:6379/ >> env.sh
	which dep || gem install dep
	which shotgun || gem install shotgun

console:
	env $$(cat env.sh) irb -r ./app

secret:
	ruby -r securerandom -e 'puts SecureRandom.hex(32)'

server:
	env $$(cat env.sh) shotgun -o 0.0.0.0

test:
	env $$(cat env.sh) cutest test/*/*_test.rb