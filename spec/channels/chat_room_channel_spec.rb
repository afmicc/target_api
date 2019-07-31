require 'rails_helper'

describe ApplicationCable::ChatRoomChannel, type: :channel do
  let!(:user) { create(:user, :confirmed) }
  let!(:chat_room) { create(:chat_room, user_owner: user) }

  before do
    stub_connection current_user: user
  end

  context 'subscribes to a stream when chat room id is provided' do
    before do
      subscribe chat_room_id: chat_room.id
    end

    it 'is expected a successful subscription' do
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_for(chat_room)
    end

    context 'send messages to chat room' do
      let(:message) { build(:message) }

      subject { perform :send_message, message: message.body, chat_room_id: chat_room.id }

      it 'is expected a increasement of messages count by 1' do
        expect { subject }.to change(Message, :count).by(1)
      end

      it 'is expected a successful broadcast of data' do
        expect { subject }.to have_broadcasted_to(chat_room)
          .from_channel(ApplicationCable::ChatRoomChannel)
          .with(a_hash_including(body: message.body,
                                 user_id: user.id,
                                 chat_room_id: chat_room.id))
      end
    end
  end

  context 'rejects when no chat room id is provided' do
    it 'is expected a rejected subscription' do
      subscribe
      expect(subscription).to be_rejected
    end
  end
end
