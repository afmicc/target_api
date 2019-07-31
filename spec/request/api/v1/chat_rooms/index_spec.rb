require 'rails_helper'

describe 'List ChatRooms', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:user_guest) { create(:user, :confirmed) }
  let!(:chat_room) do
    create(:chat_room, :with_messages,
           user_owner: user,
           user_guest: user_guest)
  end

  describe 'GET api/v1/targets' do
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
        body = (JSON response.body)
        last = json_value(body, 'chat_rooms').last
        expect(json_value(last, 'id')).not_to be_nil
        expect(json_value(last, 'user_owner_id')).to eq chat_room.user_owner_id
        expect(json_value(last, 'user_guest_id')).to eq chat_room.user_guest_id
        expect(json_value(last, 'title')).to eq chat_room.title
      end
    end

    context 'when the user is not logged in' do
      it 'is expected an unauthorized response' do
        get api_v1_chat_rooms_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
