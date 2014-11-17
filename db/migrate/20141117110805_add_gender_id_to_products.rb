class AddGenderIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :gender, index: true
  end
end
