Capriccio
==============

Requirements
----------------

- [Docker](https://www.docker.com/)

Development
-----------

```
git clone https://github.com/chromee/capriccio
cd capriccio
cp .env.dev.example .env.dev
docker-compose up -d
docker-compose exec app rake db:setup

# Open http://localhost:3000 on browser!
```

Production
-----------

```
git clone https://github.com/chromee/capriccio
cd capriccio
cp .env.dev.example .env
docker-compose up -d
docker-compose exec app rake db:setup

# if assets are not loaded.
docker-compose exec app bundle exec rake assets:clobber RAILS_ENV=production
docker-compose exec app bundle exec rake assets:precompile RAILS_ENV=production
docker-compose restart

# Open http://localhost:3000 on browser!
```