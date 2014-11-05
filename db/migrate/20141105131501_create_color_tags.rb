class CreateColorTags < ActiveRecord::Migration
  def change
    create_table :color_tags do |t|
      t.references :color, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
