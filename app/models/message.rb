# == Schema Information
#
# Table name: messages
#
#  id           :bigint           not null, primary key
#  body         :text             not null
#  user_id      :bigint           not null
#  chat_room_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  validates :body, presence: true, length: { maximum: 1000 }
end
