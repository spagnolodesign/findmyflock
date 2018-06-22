# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
  `EDITOR="atom --wait" bin/rails credentials:edit`

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

  STAGING
  Deploy from Heroku Dashboard (Deploy -> Select Branch master -> deploy)

  In case of pending migrations or new db changes run:
  `heroku restart; heroku pg:reset DATABASE --confirm staging-findmyflock;  heroku run rake db:migrate; heroku run rake db:seed`

  PRODUCTION
  `heroku restart  --app production-find-my-flock;
  heroku run rake db:migrate --app production-find-my-flock;
  heroku run rake db:seed --app production-find-my-flock;


* ...
