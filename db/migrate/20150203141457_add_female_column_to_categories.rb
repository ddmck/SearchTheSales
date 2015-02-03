class AddFemaleColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :female_only, :boolean
  end
end
