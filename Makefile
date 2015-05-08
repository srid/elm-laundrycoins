all:
	heroku docker:start

deploy:
	heroku docker:release
