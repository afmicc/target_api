require 'rails_helper'

describe ChatRoom, type: :model do
  describe 'validations' do
    subject { build(:chat_room) }

    it { is_expected.to validate_presence_of(:title) }
  end
  describe 'associations' do
    subject { create(:chat_room) }

    it { is_expected.to belong_to(:user_owner) }
    it { is_expected.to belong_to(:user_guest) }
    it { is_expected.to have_many(:messages) }
  end
end
