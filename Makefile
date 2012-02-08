compile:
	@@bundle exec middleman build && git add . && git commit -m "Build"

server:
	@@bundle exec middleman

deploy:
	@@git push heroku master