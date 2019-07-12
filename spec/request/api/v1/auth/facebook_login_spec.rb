# require 'rails_helper'

# describe 'Auth', type: :request do
#   let(:user) { build(:user) }
#   let(:params) do
#     {
#       name: user.name,
#       email: user.email,
#       password: user.password,
#       password_confirmation: user.password
#     }
#   end

#   describe 'GET api/v1/auth/facebook' do
#     context 'when the user select facebook login option' do
#       before do
#         stub_request(:get, api_v1_user_facebook_omniauth_authorize_path)
#           .to_return(status: :moved_permanently,
#                      headers: { location: api_v1_user_facebook_omniauth_callback_path },
#                      body: '{\
#                               status: "connected",\
#                               authResponse:\
#                                 {\
#                                   accessToken: "...",\
#                                   expiresIn: "...",\
#                                   reauthorize_required_in: "...",\
#                                   signedRequest: "...",\
#                                   userID: "..."\
#                                 }\
#                             }')
#       end

#       it do
#         get api_v1_user_facebook_omniauth_authorize_path
#         expect(response).to have_http_status(:moved_permanently)
#       end
#     end
#   end
# end
