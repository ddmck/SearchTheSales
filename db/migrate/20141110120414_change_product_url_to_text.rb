class ChangeProductUrlToText < ActiveRecord::Migration
  def change
    change_column :products, :url, :text
  end
end
