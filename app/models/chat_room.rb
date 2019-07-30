class ChatRoom < ActiveRecord::Base
  belongs_to :user_owner, class_name: :User, foreign_key: 'user_owner_id'
  belongs_to :user_guest, class_name: :User, foreign_key: 'user_guest_id'
  has_many :messages, dependent: :destroy
end
