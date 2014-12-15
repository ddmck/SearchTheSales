class CreateFeatureLinks < ActiveRecord::Migration
  def change
    create_table :feature_links do |t|
      t.string :name
      t.string :link_url
      t.references :feature, index: true

      t.timestamps
    end
  end
end
