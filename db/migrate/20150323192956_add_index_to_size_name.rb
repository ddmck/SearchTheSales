class AddIndexToSizeName < ActiveRecord::Migration
  def change
    add_index :sizes, :name
  end
end
