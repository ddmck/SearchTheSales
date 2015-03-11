class AddFeaturedToColors < ActiveRecord::Migration
  def change
    add_column :colors, :featured, :boolean
  end
end
