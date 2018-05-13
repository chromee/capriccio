anicap2
==============

Requirements
----------------

- [Docker](https://www.docker.com/)

Development
-----------

```bash
git clone https://github.com/chromee/anicap2
cd anicap2
cp .env.dev.example .env.dev
docker-compose up -d
docker-compose exec rails rake db:setup

# Open http://localhost:21132 on browser!
```