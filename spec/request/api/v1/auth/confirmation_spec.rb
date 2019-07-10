require 'rails_helper'

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

  describe 'POST api/v1/auth/confirmation' do
    before do
      post api_v1_user_registration_path sign_up_params
      @confirmation_url = email_confirmation_url last_email
    end

    context 'when the request is succesful' do
      before do
        get @confirmation_url
      end

      it 'is expected a successful response' do
        expect(response).to have_http_status(:found)
      end

      it 'is expected that user is confirmed' do
        expect(User.last.confirmed?).to eq true
      end
    end

    context 'when the request data is not valid' do
      before do
        @confirmation_url = replace_confirmation_token(@confirmation_url)
      end

      it 'is expected a fail response' do
        expect { get @confirmation_url }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when the request is not called' do
      it 'is expected that user is not confirmed' do
        expect(User.last.confirmed?).to eq false
      end
    end
  end
end
