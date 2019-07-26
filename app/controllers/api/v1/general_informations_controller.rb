module Api
  module V1
    class GeneralInformationsController < ApiController
      def show
        @info = GeneralInformation.find_by! key: params[:key]
      end
    end
  end
end
