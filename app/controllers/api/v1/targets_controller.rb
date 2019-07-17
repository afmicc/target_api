module Api
  module V1
    class TargetsController < ApiController
      def index
        @targets = current_api_v1_user.targets
      end

      def create
        @target = current_api_v1_user.targets.create!(target_params)
      end

      def target_params
        params.require(:target).permit(:area_lenght, :title, :topic, :latitude, :longitude)
      end
    end
  end
end
