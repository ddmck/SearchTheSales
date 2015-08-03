class AddUbToStore < ActiveRecord::Migration
  def change
    add_column :stores, :ub, :boolean, :default => false
  end
end
