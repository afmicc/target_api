class AddTopicReferenceToTarget < ActiveRecord::Migration[5.2]
  def change
    remove_column :targets, :topic
    add_reference :targets, :topic, foreign_key: true, index: true, null: false
  end
end
