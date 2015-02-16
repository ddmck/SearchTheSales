class AddReturnsInfoToStore < ActiveRecord::Migration
  def change
    add_column :stores, :days_to_return, :integer
    add_column :stores, :returns_copy, :text
  end
end
