class AddRelationToMessages < ActiveRecord::Migration
  def change
  	add_column :users, :admin_id, :integer, :index => true
  end
end
