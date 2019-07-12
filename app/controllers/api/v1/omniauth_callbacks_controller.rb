# module Api
#   module V1
#     class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
#       prepend_before_action(only: [:facebook]) { request.env["devise.skip_timeout"] = true }
#       def facebook
#         byebug
#         # if @user.persisted?
#         #   byebug
#         #   sign_in_and_redirect @user, event: :authentication
#         #   # sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
#         #   # set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
#         #   # render_data_or_redirect('deliverCredentials', @user.as_json)
#         #   byebug
#         #   render(json: @user.to_json)

#         # else
#         #   byebug
#         #   session["devise.facebook_data"] = request.env["omniauth.auth"]
#         #   redirect_to new_user_registration_url
#         # end

#       end
#       def failure
#         redirect_to root_path
#       end
#     end
#   end
# end
