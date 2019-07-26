class AlterTargetTable < ActiveRecord::Migration[5.2]
  def change
    change_column :targets, :longitude, :float
    change_column :targets, :latitude, :float

    add_column :targets, :location, :text

    add_index :targets, [:latitude, :longitude]
  end
end
