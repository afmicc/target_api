module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def account_update_params
        params.permit(:name, :gender)
      end

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :name, :gender)
      end
    end
  end
end
