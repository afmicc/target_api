module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_api_v1_user!

      rescue_from ActiveRecord::RecordInvalid, with: :show_errors

      private

      def show_errors(exception)
        render json: { error: exception.message, status: :unprocessable_entity },
               status: :unprocessable_entity
      end
    end
  end
end
