class CreateContactAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_admins do |t|
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
