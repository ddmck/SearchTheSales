web: bundle exec puma -C config/puma.rb
worker_queue_one: QUEUE=data_feeds bundle exec rake jobs:work
worker_queue_two: QUEUE=indexes bundle exec rake jobs:work
worker_queue_three: QUEUE=default bundle exec rake jobs:work
