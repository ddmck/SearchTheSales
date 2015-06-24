class AddRelationToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :admin_id, :integer, :index => true
  end
end
