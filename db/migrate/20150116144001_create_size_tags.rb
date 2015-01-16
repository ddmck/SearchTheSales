class CreateSizeTags < ActiveRecord::Migration
  def change
    create_table :size_tags do |t|
      t.references :product, index: true
      t.references :size, index: true

      t.timestamps
    end
  end
end
