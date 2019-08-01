module ApplicationCable
  class ChatRoomChannel < ApplicationCable::Channel
    def subscribed
      stream_for chat_room(params['chat_room_id'])
    rescue StandardError
      transmit error: I18n.t('api.errors.not_found')
      reject
    end

    def unsubscribed
      current_user.update_active_chat_room nil
    end

    def send_message(data)
      ActiveRecord::Base.transaction do
        body = data['message']
        chat_room_id = data['chat_room_id']

        message = current_user.messages.create! body: body, chat_room_id: chat_room_id

        notify(chat_room(chat_room_id), message)
      end
    end

    private

    def chat_room(chat_room_id)
      current_user.chat_rooms.find(chat_room_id)
    end

    def notify(chat_room, message)
      self.class.broadcast_to chat_room,
                              body: message.body,
                              user_id: message.user_id,
                              chat_room_id: message.chat_room_id,
                              created_at: message.created_at

      user = notificable_user(chat_room)
      NotificationService.new.send_new_message(user, chat_room, message) if user
    end

    def notificable_user(chat_room)
      owner = chat_room.user_owner
      guest = chat_room.user_guest
      current_id = current_user.id
      user = if current_id != owner.id
               owner
             elsif current_id != guest.id
               guest
             end
      return user if !user.active_chat_room_id? || user.active_chat_room.id != chat_room.id
    end
  end
end
