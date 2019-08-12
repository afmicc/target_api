require 'rails_helper'

describe 'GET api/v1/user/id', type: :request do
  let!(:user) { create(:user, :confirmed, :with_avatar) }

  subject { get api_v1_user_path(user), headers: auth_header }

  context 'when the request is succesful and user has avatar' do
    before do
      subject
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains some body data' do
      expect(response.body).to include_json(
        user: {
          id: user.id,
          name: user.name,
          gender: user.gender,
          avatar: %r{^(http|https):\/\/[^ "]+$}
        }
      )
    end
  end

  context "when the request is succesful and user doesn't have avatar" do
    before do
      subject
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains some body data' do
      expect(response.body).to include_json(
        user: {
          id: user.id,
          name: user.name,
          gender: user.gender
        }
      )
    end
  end

  context 'when the user is not logged in' do
    it 'is expected an unauthorized response' do
      get api_v1_user_path(user)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
