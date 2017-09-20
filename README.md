anicap2
==============

Requirements
----------------

- [Docker](https://www.docker.com/)

Install
-----------

```
git clone https://github.com/chromee/anicap2
cd anicap2
docker-compose up -d
docker-compose run app rake db:setup
```