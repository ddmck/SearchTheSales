class AddStyleToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :style, index: true
  end
end
