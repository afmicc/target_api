# module Api
#   module V1
#     class SessionsController < DeviseTokenAuth::SessionsController
#       prepend_before_action(only: [:facebook]) { request.env["devise.skip_timeout"] = true }
#     end
#   end
# end
