class AddDeeplinkToProduct < ActiveRecord::Migration
  def change
    add_column :products, :deeplink, :text
  end
end
