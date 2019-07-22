module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_model_errors
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_errors

      private

      def invalid_model_errors(exception)
        logger.error exception.message
        render json: { error: I18n.t('api.errors.invalid_model'), status: :unprocessable_entity },
               status: :unprocessable_entity
      end

      def not_found_errors(exception)
        logger.error exception.message
        render json: { error: I18n.t('api.errors.not_found'), status: :not_found },
               status: :not_found
      end
    end
  end
end
