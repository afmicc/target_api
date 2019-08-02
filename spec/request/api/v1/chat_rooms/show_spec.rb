require 'rails_helper'

describe 'GET api/v1/chat_rooms/{id}', type: :request do
  let!(:user) { create(:user, :confirmed) }
  let!(:target) { create(:target, user: user) }
  let!(:user_guest) { create(:user, :confirmed) }
  let!(:target_guest) { create(:target, user: user_guest) }
  let!(:chat_room) do
    create(:chat_room, :with_messages,
           messages_count: 7,
           user_owner: user,
           user_guest: user_guest,
           target_owner: target,
           target_guest: target_guest)
  end

  context 'when the request is succesful' do
    subject { get api_v1_chat_room_path(chat_room), headers: auth_header }

    it 'is expected a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'is expected that response contains some body data' do
      subject
      body = (JSON response.body)
      expect(json_value(body, 'chat_room', 'id')).not_to be_nil
      expect(json_value(body, 'chat_room', 'user_owner_id')).to eq chat_room.user_owner_id
      expect(json_value(body, 'chat_room', 'user_guest_id')).to eq chat_room.user_guest_id
      expect(json_value(body, 'chat_room', 'title')).to eq target.title
      expect(json_value(body, 'chat_room', 'target_id')).to eq target.id
      expect(json_value(body, 'chat_room', 'unread_messages')).to be >= 0
      expect(json_value(body, 'chat_room', 'messages').count).to eq 7
      messages = json_value(body, 'chat_room', 'messages')
      message = messages.last
      expect(json_value(message, 'id')).not_to be_nil
      expect(json_value(message, 'user_id')).to eq chat_room.messages.last.user_id
      expect(json_value(message, 'user_name')).to eq chat_room.messages.last.user.name
      expect(json_value(message, 'body')).to eq chat_room.messages.last.body
      expect(DateTime.parse(json_value(message, 'created_at')).to_i)
        .to equal chat_room.messages.last.created_at.to_i
    end

    it 'is expected that sender user change the active chat room info' do
      expect { subject }.to change { user.reload.active_chat_room }.from(nil).to(chat_room)
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
