module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!

      def update
        current_api_v1_user.update!(update_params)
        render json: current_api_v1_user, status: :ok
      end

      private

      def update_params
        params.require(:user).permit(:name, :gender)
      end
    end
  end
end
