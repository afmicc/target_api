class AddCountsToChatRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_rooms, :unread_messages_owner, :integer, default: 0
    add_column :chat_rooms, :unread_messages_guest, :integer, default: 0
  end
end
