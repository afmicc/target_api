require 'rails_helper'

describe 'Auth - sign in', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let(:sign_in_params) do
    {
      email: user.email,
      password: user.password
    }
  end

  describe 'POST api/v1/auth/sign_in' do
    context 'when the credentials are rigths' do
      before do
        post user_session_path sign_in_params
      end

      it 'is expected a successful response' do
        expect(response).to be_successful
      end

      it 'is expected that response contains some headers' do
        expect(json_value(response.headers, 'access-token')).not_to be_nil
        expect(json_value(response.headers, 'client')).not_to be_nil
        expect(json_value(response.headers, 'expiry')).not_to be_nil
        expect(json_value(response.headers, 'uid')).to eq user.email
      end

      it 'is expected that response contains some body data' do
        expect(response.body).to include_json(
          data:
            {
              id: user.id,
              uid: user.email,
              email: user.email,
              name: user.name
            }
        )
      end

      it 'is expected a successful response to other queries' do
        auth_header = auth_user_header response.headers
        get api_v1_auth_validate_token_path, headers: auth_header
        expect(response).to be_successful
      end
    end

    context 'when not valid' do
      context 'when credentials are missing' do
        it 'requires the email parameter' do
          sign_in_params[:email] = ''
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'requires the password parameter' do
          sign_in_params[:password] = ''
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'requires email and password parameters' do
          sign_in_params[:email] = ''
          sign_in_params[:password] = ''
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when credentials are wrong' do
        it 'requires correct email parameter' do
          sign_in_params[:email] = Faker::Internet.email('Tester')
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'requires correct password parameter' do
          sign_in_params[:password] = Faker::Internet.password(10, 20)
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'requires correct email and password parameters' do
          sign_in_params[:email] = Faker::Internet.email('Tester')
          sign_in_params[:password] = Faker::Internet.password(10, 20)
          post user_session_path sign_in_params
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when credentials are from a admin user' do
        let!(:admin) { create(:admin_user) }
        let(:admin_sign_in_params) do
          {
            email: admin.email,
            password: admin.password
          }
        end

        before do
          post user_session_path admin_sign_in_params
        end

        it 'is expected an unauthorized response' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
