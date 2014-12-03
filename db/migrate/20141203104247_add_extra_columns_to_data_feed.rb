class AddExtraColumnsToDataFeed < ActiveRecord::Migration
  def change
    add_column :data_feeds, :gender_column, :string
    add_column :data_feeds, :category_column, :string
  end
end
