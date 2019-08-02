# == Schema Information
#
# Table name: chat_rooms
#
#  id                    :bigint           not null, primary key
#  user_owner_id         :bigint           not null
#  user_guest_id         :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  unread_messages_owner :integer          default(0)
#  unread_messages_guest :integer          default(0)
#  target_owner_id       :bigint           not null
#  target_guest_id       :bigint           not null
#

class ChatRoom < ActiveRecord::Base
  belongs_to :user_owner, class_name: :User, foreign_key: 'user_owner_id'
  belongs_to :user_guest, class_name: :User, foreign_key: 'user_guest_id'
  has_many :messages, dependent: :destroy
  belongs_to :target_owner, class_name: :Target, foreign_key: 'target_owner_id'
  belongs_to :target_guest, class_name: :Target, foreign_key: 'target_guest_id'

  validates :unread_messages_owner, :unread_messages_guest,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def notificable_user(current_user)
    user = if guest?(current_user)
             user_owner
           elsif owner?(current_user)
             user_guest
           end
    return user if !user.active_chat_room_id? || user.active_chat_room.id != id
  end

  def increment_unread_messages(user)
    update_unread_messages(user, 1)
  end

  def reset_unread_messages(user)
    update_unread_messages(user, 0)
  end

  def owner?(user)
    user.id == user_owner.id
  end

  def guest?(user)
    user.id == user_guest.id
  end

  private

  def update_unread_messages(user, new_value)
    is_reset = new_value.zero?
    if owner?(user)
      update! unread_messages_owner: (is_reset ? 0 : unread_messages_owner + new_value)
    elsif guest?(user)
      update! unread_messages_guest: (is_reset ? 0 : unread_messages_guest + new_value)
    end
  end
end
