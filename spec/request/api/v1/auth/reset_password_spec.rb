require 'rails_helper'

describe 'PUT api/v1/auth/password', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:reset_url) { email_link_url last_email }
  let(:params) do
    {
      email: user.email,
      redirect_url: 'http://localhost:3000'
    }
  end
  let(:new_params) do
    new_password = Faker::Internet.password(10, 20)
    {
      password: new_password,
      password_confirmation: new_password
    }
  end

  before do
    post user_password_path params
  end

  context 'when the request is succesful' do
    before do
      get reset_url
      headers = url_query_parameters(response.location)
      put user_password_path, params: new_params, headers: headers
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains some body data' do
      body = JSON response.body
      expect(json_value(body, 'data', 'id')).not_to be_nil
      expect(json_value(body, 'data', 'uid')).to eq user.email
      expect(json_value(body, 'data', 'email')).to eq user.email
      expect(json_value(body, 'data', 'name')).to eq user.name
    end

    it 'is expected that new password is valid' do
      expect(user.reload.valid_password?(new_params[:password])).to be true
    end

    it 'is expected that old password isn\'t valid' do
      old_password = user.password
      expect(user.reload.valid_password?(old_password)).to be false
    end
  end

  context 'when the reset url is not valid' do
    let(:new_reset_url) { replace_param_token(reset_url, 'reset_password_token') }

    it 'is expected a fail response' do
      expect { get new_reset_url }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'when missing the headers parameters' do
    it 'is expected an unauthorized response' do
      put user_password_path, params: new_params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when the headers are invalid' do
    before do
      get reset_url
      @headers = url_query_parameters(response.location)
    end

    it 'requires correct access-token header' do
      @headers['access-token'] = Faker::Alphanumeric.alphanumeric 20
      put user_password_path, params: new_params, headers: @headers
      expect(response).to have_http_status(:unauthorized)
    end

    it 'requires correct uid header' do
      @headers['uid'] = Faker::Internet.email('Tester')
      put user_password_path, params: new_params, headers: @headers
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
