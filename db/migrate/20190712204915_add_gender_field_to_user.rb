class AddGenderFieldToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer, null: false
  end
end
