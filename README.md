Capriccio
==============

Requirements
----------------

- [Docker](https://www.docker.com/)

Development
-----------

```bash
git clone https://github.com/chromee/capriccio
cd capriccio
cp .env.dev.example .env.dev
docker-compose up -d
docker-compose exec rails rake db:setup

# Open http://localhost:21132 on browser!
```