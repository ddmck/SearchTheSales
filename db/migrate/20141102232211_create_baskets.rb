class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
