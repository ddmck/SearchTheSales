class CreateBrandReferences < ActiveRecord::Migration
  def change
    create_table :brand_references do |t|
      t.string :reference
      t.integer :brand_id
      t.belongs_to :brand, index: true
      
      t.timestamps
    end
  end
end
