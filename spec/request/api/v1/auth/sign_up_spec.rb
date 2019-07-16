require 'rails_helper'

describe 'Auth', type: :request do
  let(:user) { build(:user) }
  let(:params) do
    {
      name: user.name,
      email: user.email,
      password: user.password,
      password_confirmation: user.password,
      gender: user.gender
    }
  end

  describe 'POST api/v1/auth' do
    context 'when the request is succesful' do
      it 'is expected a successful response' do
        post api_v1_user_registration_path params
        expect(response).to be_successful
      end

      it 'is expected a increasement of user count by 1' do
        expect do
          post api_v1_user_registration_path params
        end.to change(User, :count).by(1)
      end

      it 'is expected that response contains some body data' do
        post api_v1_user_registration_path params
        body = JSON response.body
        expect(json_value(body, 'status')).to eq 'success'
        expect(json_value(body, 'data', 'id')).not_to be_nil
        expect(json_value(body, 'data', 'uid')).to eq user.email
        expect(json_value(body, 'data', 'email')).to eq user.email
        expect(json_value(body, 'data', 'name')).to eq user.name
        expect(json_value(body, 'data', 'gender')).to eq user.gender
      end

      it 'is expected that confirmation mail is sent' do
        post api_v1_user_registration_path params
        expect(last_email).not_to be_nil
      end
    end

    context 'when the request is fail' do
      it 'requires the name parameter' do
        params.delete :name
        post api_v1_user_registration_path params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'requires the email parameter' do
        params.delete :email
        post api_v1_user_registration_path params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'requires the password parameter' do
        params.delete :password
        post api_v1_user_registration_path params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'requires the password_confirmation parameter' do
        params[:password_confirmation] = ''
        post api_v1_user_registration_path params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'requires the gender parameter' do
        params.delete :gender
        post api_v1_user_registration_path params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
