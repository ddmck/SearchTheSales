class CreateTrendTags < ActiveRecord::Migration
  def change
    create_table :trend_tags do |t|
      t.references :product, index: true
      t.references :trend, index: true

      t.timestamps
    end
  end
end
