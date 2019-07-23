require 'rails_helper'

describe 'Auth - confirmation', type: :request do
  let(:user) { build(:user) }
  let(:sign_up_params) do
    {
      name: user.name,
      email: user.email,
      password: user.password,
      password_confirmation: user.password,
      gender: user.gender
    }
  end
  let(:confirmation_url) { email_link_url last_email }

  describe 'POST api/v1/auth/confirmation' do
    before do
      post user_registration_path sign_up_params
    end

    context 'when the request is succesful' do
      it 'is expected a successful response' do
        get confirmation_url
        expect(response).to have_http_status(:found)
      end

      it 'is expected that user is confirmed' do
        expect { get confirmation_url }.to change { User.last.confirmed? }.from(false).to(true)
      end
    end

    context 'when the request data is not valid' do
      let(:new_confirmation_url) { replace_param_token(confirmation_url, 'confirmation_token') }

      it 'is expected a fail response' do
        expect { get new_confirmation_url }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
