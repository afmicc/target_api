module Api
  module V1
    class ChatRoomsController < ApiController
      def index
        @chat_rooms = current_user.chat_rooms
      end

      def show
        chat_room = current_user.chat_rooms.includes(:messages).find_by!(id: params[:id])
        current_user.update_active_chat_room chat_room
        @chat_room = chat_room
      end
    end
  end
end
