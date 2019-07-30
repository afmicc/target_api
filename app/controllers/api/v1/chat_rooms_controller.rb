module Api
  module V1
    class ChatRoomsController < ApiController
      def index
        @chat_rooms = current_user.chat_rooms
      end

      def show
        @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      end
    end
  end
end
