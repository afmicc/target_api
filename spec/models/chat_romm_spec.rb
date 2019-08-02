require 'rails_helper'

describe ChatRoom, type: :model do
  describe 'validations' do
    subject { build(:chat_room) }

    it {
      is_expected.to validate_numericality_of(:unread_messages_owner)
        .only_integer
        .is_greater_than_or_equal_to(0)
    }
    it {
      is_expected.to validate_numericality_of(:unread_messages_guest)
        .only_integer
        .is_greater_than_or_equal_to(0)
    }
  end
  describe 'associations' do
    subject { create(:chat_room) }

    it { is_expected.to belong_to(:user_owner) }
    it { is_expected.to belong_to(:user_guest) }
    it { is_expected.to have_many(:messages) }
    it { is_expected.to belong_to(:target_owner) }
    it { is_expected.to belong_to(:target_guest) }
  end
end
