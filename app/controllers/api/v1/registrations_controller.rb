module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :name)
      end
    end
  end
end
