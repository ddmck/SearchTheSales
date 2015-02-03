class AddActiveToDatafeeds < ActiveRecord::Migration
  def change
    add_column :data_feeds, :active, :boolean
  end
end
