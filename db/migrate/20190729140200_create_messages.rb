class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body, null: false, limit: 1000
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true

      t.timestamps
    end
  end
end
