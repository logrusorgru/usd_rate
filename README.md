README
======

### Prepare

- install related gems

```
bundle install
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

- start redis server or make sure it started

- start the app

```
foreman start
```

- add exchange rate fethcing to cron and execute the fetching

```
foreman run bundle exec whenever -w
foreman run bundle exec bin/rails runner 'FetchRateJob.perform_later'
```
