require 'rails_helper'

describe 'Auth', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:auth_header) { user.create_new_auth_token }

  describe 'DELETE api/v1/auth/sign_out' do
    context 'when the request is succesful' do
      before do
        delete destroy_api_v1_user_session_path, headers: auth_header
      end
      it 'is expected a successful response' do
        expect(response).to be_successful
      end

      it 'is expected a unauthorized response to other queries' do
        get api_v1_auth_validate_token_path, headers: auth_header
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the request is fail' do
      it 'requires correct access-token header' do
        auth_header['access-token'] = Faker::Alphanumeric.alphanumeric 20
        delete destroy_api_v1_user_session_path, headers: auth_header
        expect(response).to have_http_status(:not_found)
      end
      it 'requires correct client header' do
        auth_header['client'] = Faker::Alphanumeric.alphanumeric 20
        delete destroy_api_v1_user_session_path, headers: auth_header
        expect(response).to have_http_status(:not_found)
      end
      it 'requires correct uid header' do
        auth_header['uid'] = Faker::Internet.email('Tester')
        delete destroy_api_v1_user_session_path, headers: auth_header
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
