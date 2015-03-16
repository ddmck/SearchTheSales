class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.boolean :featured

      t.timestamps
    end
  end
end
