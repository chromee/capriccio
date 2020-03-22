Capriccio
==============

Requirements
----------------

- [Docker](https://www.docker.com/)

Getting Started
-----------

```
git clone https://github.com/chromee/capriccio
cd capriccio
cp .env.example .env
docker-compose up -d
docker-compose exec rails rake db:setup

# Open http://localhost:3000 on browser!
```

Dev
-----------
```
 docker-compose run --service-ports rails
```


Memo
-----------

```
# if assets are not loaded.
docker-compose run rails bundle exec rake assets:clobber RAILS_ENV=production
docker-compose run rails bundle exec rake assets:precompile RAILS_ENV=production
docker-compose restart
```