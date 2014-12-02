class DataFeedImport
  include ::ScheduledJob

  def perform
    DataFeed.all.each do |df|
      df.process_file
    end
  end

  def self.time_to_recur(run_at)
    run_at + 30.seconds
  end

end