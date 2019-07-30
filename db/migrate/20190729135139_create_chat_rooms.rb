class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.references :user_owner, foreign_key: { to_table: :users }, null: false
      t.references :user_guest, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
