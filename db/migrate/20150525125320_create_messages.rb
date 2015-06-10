class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :sender_id
      t.references :user, index: true
      t.datetime :seen

      t.timestamps
    end
  end
end
