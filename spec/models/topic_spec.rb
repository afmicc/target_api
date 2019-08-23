# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Topic, type: :model do
  describe 'validations' do
    subject { build(:topic) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'associations' do
    subject { create(:topic) }

    it { is_expected.to have_many(:targets) }
  end
end
