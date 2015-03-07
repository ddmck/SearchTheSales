class DropColorTagsTable < ActiveRecord::Migration
  def change
    drop_table :color_tags
  end
end
