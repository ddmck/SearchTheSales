class RemoveGenderFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :gender
  end
end
