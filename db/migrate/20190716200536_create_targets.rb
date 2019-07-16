class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.belongs_to :user, index: true, null: false
      t.integer :area_lenght, null: false
      t.string :title, null: false
      t.integer :topic, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false

      t.timestamps
    end
  end
end
