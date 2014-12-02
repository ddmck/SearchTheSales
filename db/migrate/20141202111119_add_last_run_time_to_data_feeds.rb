class AddLastRunTimeToDataFeeds < ActiveRecord::Migration
  def change
    add_column :data_feeds, :last_run_time, :datetime
  end
end
