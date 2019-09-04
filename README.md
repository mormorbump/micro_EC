# test seed
User 1
Product 2
run `rails db:seed`

# docker rails template

Docker template for Rails app or Rails + Webpacker app development.

## Use for development

This template use [entrykit](https://github.com/progrium/entrykit) to execute `bundle install` on ENTRYPOINT of Docker.

No re-build docker image on changing Gemfile because bundled gems is cached in Docker Volume.

To develop rails app, use following commands.

```bash
script/bootstrap
docker-compose exec rails bash
```

You can execute any commands in docker container.

## Getting started

You can build rails app from template like this.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/base/ruby-2.6.2-rails-5.2.2.1-webpack
git branch -d master && git checkout -b master
script/init && script/bootstrap

docker-compose up -d
docker-compose exec rails bash
# access to http://localhost:3000
```

### built branch

`ruby-RUBY_VERSION-rails-RAILS_VERSION` branch has built application.

Please initialize secrets and start to development.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/ruby-2.6.2-rails-5.2.2.1-webpack
git branch -d master && git checkout -b master
script/bootstrap
# initialize credentials.yml.enc
docker-compose run --rm rails bin/rails credentials:edit
```

- [ruby-2.6.2-rails-5.2.2.1](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.6.2-rails-5.2.2.1)
- [ruby-2.6.2-rails-5.2.2.1-webpack](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.6.2-rails-5.2.2.1-webpack)

## License

MIT
