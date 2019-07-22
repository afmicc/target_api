module Api
  module V1
    class ContactAdminController < ApiController
      def create
        ContactAdmin.create!(contact_admin_params)

        # TODO: send mail to admin
      end

      private

      def contact_admin_params
        params.require(:contactAdmin).permit(:email, :message)
      end
    end
  end
end
