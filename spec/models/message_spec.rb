# == Schema Information
#
# Table name: messages
#
#  id           :bigint           not null, primary key
#  body         :text             not null
#  user_id      :bigint           not null
#  chat_room_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Message, type: :model do
  describe 'validations' do
    subject { build(:message) }

    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1000) }
  end
  describe 'associations' do
    subject { create(:message) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat_room) }
  end
end
