require 'rails_helper'

describe 'GET api/v1/chat_rooms/{id}', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:chat_room) { create(:chat_room, :with_messages, messages_count: 7, user_owner: user) }

  context 'when the request is succesful' do
    before do
      get api_v1_chat_room_path(chat_room), headers: auth_header
    end

    it 'is expected a successful response' do
      expect(response).to be_successful
    end

    it 'is expected that response contains some body data' do
      expect(response.body).to include_json(
        chat_room:
        {
          id: /\d/,
          user_owner_id: chat_room.user_owner_id,
          user_guest_id: chat_room.user_guest_id,
          title: chat_room.title,
          messages:
          [
            { id: /\d/ },
            { id: /\d/ },
            { id: /\d/ },
            { id: /\d/ },
            { id: /\d/ },
            { id: /\d/ },
            {
              id: /\d/,
              user_id: chat_room.messages.last.user_id,
              user_name: chat_room.messages.last.user.name,
              body: chat_room.messages.last.body
            }
          ]
        }
      )
    end
  end

  context "when the key doesn't exist" do
    before do
      new_id = chat_room.id + 100
      get api_v1_chat_room_path(new_id), headers: auth_header
    end

    it 'is expected a not found response' do
      expect(response).to have_http_status(:not_found)
    end

    it 'is expected an error message' do
      body = JSON response.body
      expect(json_value(body, 'error')).to eq I18n.t('api.errors.not_found')
    end
  end

  context 'when the user is not logged in' do
    it 'is expected an unauthorized response' do
      get api_v1_chat_room_path(chat_room)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
