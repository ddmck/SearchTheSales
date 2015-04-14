class AddSizeNameToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :size_name, :string
  end
end
