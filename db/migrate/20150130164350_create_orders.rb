class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.decimal :total
      t.text :address

      t.timestamps
    end
  end
end
