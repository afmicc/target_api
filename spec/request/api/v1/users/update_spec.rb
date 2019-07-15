require 'rails_helper'

describe 'Update Users', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:auth_header) { user.create_new_auth_token }
  let(:params) do
    {
      user: build(:user).attributes
    }
  end

  describe 'PUT api/v1/users/1' do
    context 'when the request is succesful' do
      before do
        put api_v1_user_path(user), params: params, headers: auth_header
      end

      it 'is expected a successful response' do
        expect(response).to be_successful
      end

      it 'is expected that response contains some body data' do
        body = JSON response.body
        expect(json_value(body, 'id')).not_to be_nil
        expect(json_value(body, 'name')).to eq params[:user]['name']
        expect(json_value(body, 'gender')).to eq params[:user]['gender']
      end

      it 'is expected that email is ignored' do
        body = JSON response.body
        expect(json_value(body, 'id')).not_to be_nil
        expect(json_value(body, 'uid')).to eq user.email
        expect(json_value(body, 'email')).to eq user.email
      end
    end
  end
end
