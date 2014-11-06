class CreateSubCategoryTags < ActiveRecord::Migration
  def change
    create_table :sub_category_tags do |t|
      t.references :sub_category, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
