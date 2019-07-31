require 'rails_helper'

describe 'GET api/v1/chat_rooms', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:user_guest) { create(:user, :confirmed) }
  let!(:chat_room) do
    create(:chat_room, :with_messages,
           user_owner: user,
           user_guest: user_guest)
  end

  before do
    get api_v1_chat_rooms_path, headers: auth_header
  end

  context 'when the request is succesful' do
    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains at least one' do
      body = JSON response.body
      expect(body).to_not be_empty
      expect(body.count).to be_positive
    end

    it 'is expected that response contains at least some body data' do
      expect(response.body).to include_json(
        chat_rooms:
        [
          {
            id: /\d/,
            user_owner_id: chat_room.user_owner_id,
            user_guest_id: chat_room.user_guest_id,
            title: chat_room.title
          }
        ]
      )
    end
  end

  context 'when the user is not logged in' do
    it 'is expected an unauthorized response' do
      get api_v1_chat_rooms_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
