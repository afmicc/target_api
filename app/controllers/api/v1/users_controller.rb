module Api
  module V1
    class UsersController < ApiController
      helper_method :user

      def update
        user.update!(update_params)
        render :show
      end

      private

      def user
        current_user
      end

      def update_params
        params.require(:user).permit(:name, :gender, avatar: [:data])
      end
    end
  end
end
