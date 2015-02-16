class AddDeliveryPriceToStore < ActiveRecord::Migration
  def change
    add_column :stores, :standard_price, :decimal
    add_column :stores, :express_price, :decimal
    add_column :stores, :free_delivery_threshold, :decimal
    add_column :stores, :delivery_copy, :text
  end
end
