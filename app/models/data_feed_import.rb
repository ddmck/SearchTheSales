class DataFeedImport
  include ::ScheduledJob

  def perform
    DataFeed.all.each do |df|
      df.process_file if df.store.ub
    end
    DataFeedXml.all.each do |df|
      df.process_file if df.store.ub
    end
  end

  def self.time_to_recur(run_at)
    run_at.end_of_day + 7.hours
  end

end
