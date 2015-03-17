class AddCatIdToStyle < ActiveRecord::Migration
  def change
    add_reference :styles, :category, index: true
  end
end
