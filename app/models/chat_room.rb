# == Schema Information
#
# Table name: chat_rooms
#
#  id            :bigint           not null, primary key
#  title         :string           not null
#  user_owner_id :bigint           not null
#  user_guest_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ChatRoom < ActiveRecord::Base
  belongs_to :user_owner, class_name: :User, foreign_key: 'user_owner_id'
  belongs_to :user_guest, class_name: :User, foreign_key: 'user_guest_id'
  has_many :messages, dependent: :destroy

  validates :title, presence: true
end
