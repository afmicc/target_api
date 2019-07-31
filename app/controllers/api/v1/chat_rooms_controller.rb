module Api
  module V1
    class ChatRoomsController < ApiController
      def index
        @chat_rooms = chat_rooms
      end

      def show
        @chat_room = chat_rooms.find(params[:id])
      end

      private

      def chat_rooms
        current_user.chat_rooms
      end
    end
  end
end
