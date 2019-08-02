module ApplicationCable
  class ChatRoomChannel < ApplicationCable::Channel
    def subscribed
      chat_room = chat_room(params['chat_room_id'])
      stream_for chat_room
      chat_room.reset_unread_messages(current_user)
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

      user = chat_room.notificable_user(current_user)
      NotificationService.new.send_new_message(user, chat_room, message) if user
      chat_room.increment_unread_messages(user) if user
    end
  end
end
