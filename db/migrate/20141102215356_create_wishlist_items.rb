class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
