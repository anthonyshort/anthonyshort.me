compile:
	@@bundle exec middleman build && git add . && git add -u && git commit -m "Build"

server:
	@@bundle exec middleman -p 1234

deploy:
	@@git push heroku master