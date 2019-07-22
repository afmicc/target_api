# == Schema Information
#
# Table name: general_informations
#
#  id         :bigint           not null, primary key
#  key        :string           not null
#  title      :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe GeneralInformation, type: :model do
  describe 'validations' do
    subject { build(:general_information) }

    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_uniqueness_of(:key).case_insensitive }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:text) }
  end
end
