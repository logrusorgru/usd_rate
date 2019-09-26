# README

redis?

```
bundle install
rake db:create
rake db:migrade
rake db:seed
rake sidekiq:start
whenever -w
bundle exec bin/rails runner 'FetchRateJob.perform_later'
rails server
```
