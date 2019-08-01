class AddActiveChatRoomToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :active_chat_room, foreign_key: { to_table: :chat_rooms }, null: true
  end
end
