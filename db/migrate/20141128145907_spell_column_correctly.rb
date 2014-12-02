class SpellColumnCorrectly < ActiveRecord::Migration
  def change
    rename_column :data_feeds, :rrp_colomn, :rrp_column
    rename_column :data_feeds, :image_url_coloum, :image_url_column
  end
end
