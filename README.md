README
======

### Prepare

- install yarn to precompile assets

```
sudo npm install yarn -g
```

- install related gems

```
bundle install --without development test
```

- database

```
foreman run bundle exec bin/rake db:create
foreman run bundle exec bin/rake db:migrate
foreman run bundle exec bin/rake db:seed
```

- assets

```
foreman run bundle exec bin/rake assets:precompile
```

- start redis server or make sure it is started
- start the app

```
foreman start
```

- add exchange rate fethcing to cron and execute the fetching

```
foreman run bundle exec whenever -w
foreman run bundle exec bin/rails runner -e production 'FetchRateJob.perform_later'
```

#### Example .env file

```
RAILS_ENV=production
RAILS_LOG_TO_STDOUT=true
SECRET_KEY_BASE=966257311db64827e93b4eba449d5175fcf15dde0c925e50fdf5d59ea24de36bc8d98c87ef1040a2b4b5513eeff5d9a40d07db9e5a032c204a8ea8b519d59eb9
RAILS_SERVE_STATIC_FILES=true
```
