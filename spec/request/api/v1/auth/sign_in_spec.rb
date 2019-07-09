require 'rails_helper'
require 'faker'

describe 'Auth', type: :request do
  let(:user) { build(:user) }
  let(:sign_up_params) do
    {
      name: user.name,
      email: user.email,
      password: user.password,
      password_confirmation: user.password
    }
  end
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  describe 'POST api/v1/auth/sign_in' do
    before do
      post api_v1_user_registration_path sign_up_params
    end
    context 'when the user insert rigth credentials' do
      before do
        post api_v1_user_session_path params
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
        body = JSON response.body
        expect(json_value(body, 'data', 'id')).not_to be_nil
        expect(json_value(body, 'data', 'uid')).to eq user.email
        expect(json_value(body, 'data', 'email')).to eq user.email
        expect(json_value(body, 'data', 'name')).to eq user.name
      end
    end

    context 'when the user insert wrong credentials' do
      it 'requires the email parameter' do
        params[:email] = ''
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'requires the password parameter' do
        params[:password] = ''
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'requires email and password parameters' do
        params[:email] = ''
        params[:password] = ''
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'requires correct email parameter' do
        params[:email] = Faker::Internet.email('Tester')
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'requires correct password parameter' do
        params[:password] = Faker::Internet.password(10, 20)
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'requires correct email and password parameters' do
        params[:email] = Faker::Internet.email('Tester')
        params[:password] = Faker::Internet.password(10, 20)
        post api_v1_user_session_path params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
