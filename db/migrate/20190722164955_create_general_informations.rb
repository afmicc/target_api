class CreateGeneralInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :general_informations do |t|
      t.string :key, null: false
      t.string :title, null: false
      t.text :text, null: false

      t.timestamps
    end

    add_index :general_informations, :key, unique: true
  end
end
