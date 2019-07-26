module Api
  module V1
    class ContactAdminController < ApiController
      def create
        ContactAdmin.create!(contact_admin_params)
      end

      private

      def contact_admin_params
        params.require(:contact_admin).permit(:email, :message)
      end
    end
  end
end
