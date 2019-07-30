module Api
  module V1
    class ChatRoomsController < ApiController
      def index
        @chat_rooms = current_user.chat_rooms
      end

      def show
        @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      end

      def create
        @chat_room = current_user.own_chat_rooms.create!(chat_room_params)
        render :show
      end

      private

      def chat_room_params
        params.require(:chat_room).permit(:title, :user_guest_id)
      end
    end
  end
end
