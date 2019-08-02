module Api
  module V1
    class TargetsController < ApiController
      def index
        @targets = user_targets
      end

      def create
        @target = user_targets.create!(target_params)
        render :show
      end

      def destroy
        target = user_targets.find(params[:id])
        target.destroy!
        head :no_content
      end

      def compatible
        @chat_rooms = current_user.chat_rooms.includes(:target_owner).includes(:target_guest)
      end

      private

      def target_params
        params.require(:target).permit(:area_lenght, :title, :topic, :latitude, :longitude)
      end

      def user_targets
        current_user.targets
      end
    end
  end
end
