class CreateBasketItems < ActiveRecord::Migration
  def change
    create_table :basket_items do |t|
      t.references :product, index: true
      t.references :basket, index: true

      t.timestamps
    end
  end
end
