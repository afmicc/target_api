# == Schema Information
#
# Table name: contact_admins
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  message    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe ContactAdmin, type: :model do
  describe 'validations' do
    subject { build(:contact_admin) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.not_to allow_value('user').for(:email) }
    it { is_expected.not_to allow_value('user_com').for(:email) }
    it { is_expected.to allow_value('user@com').for(:email) }
    it { is_expected.to allow_value('user@mail.com').for(:email) }
  end
end
