module ApplicationCable
  class ChatRoomChannel < ApplicationCable::Channel
    def subscribed
      stream_for chat_room(params['chat_room_id'])
    rescue StandardError
      transmit error: I18n.t('api.errors.not_found')
      reject
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def send_message(data)
      ActiveRecord::Base.transaction do
        message = current_user.messages.create! body: data['message'],
                                                chat_room_id: data['chat_room_id']

        self.class.broadcast_to chat_room(data['chat_room_id']),
                                message: message.to_json
      end
    end

    private

    def chat_room(chat_room_id)
      current_user.chat_rooms.find(chat_room_id)
    end
  end
end
