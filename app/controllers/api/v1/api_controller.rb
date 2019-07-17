module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordInvalid, with: :show_errors

      private

      def show_errors(exception)
        logger.error exception.message
        render json: { error: I18n.t('api.errors.invalid_model'), status: :unprocessable_entity },
               status: :unprocessable_entity
      end
    end
  end
end
