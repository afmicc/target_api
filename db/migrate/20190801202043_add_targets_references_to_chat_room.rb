class AddTargetsReferencesToChatRoom < ActiveRecord::Migration[5.2]
  def change
    add_reference :chat_rooms, :target_owner, foreign_key: { to_table: :targets }, null: false
    add_reference :chat_rooms, :target_guest, foreign_key: { to_table: :targets }, null: false

    remove_column :chat_rooms, :title
  end
end
