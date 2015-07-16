HireFire::Resource.configure do |config|
  config.dyno(:worker_queue_one) do
    HireFire::Macro::Delayed::Job.queue(:data_feeds, :mapper => :active_record)
  end

  config.dyno(:worker_queue_two) do
    HireFire::Macro::Delayed::Job.queue(:indexes, :mapper => :active_record)
  end

  config.dyno(:worker_queue_three) do
    HireFire::Macro::Delayed::Job.queue(:default, :mapper => :active_record)
  end
end
