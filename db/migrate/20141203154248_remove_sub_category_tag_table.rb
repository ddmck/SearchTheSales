class RemoveSubCategoryTagTable < ActiveRecord::Migration
  def change
    drop_table :sub_category_tags
  end
end
