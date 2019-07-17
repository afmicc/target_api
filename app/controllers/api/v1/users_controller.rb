module Api
  module V1
    class UsersController < ApiController
      def update
        current_api_v1_user.update!(update_params)
        @user = current_api_v1_user
        render :show
      end

      private

      def update_params
        params.require(:user).permit(:name, :gender)
      end
    end
  end
end
