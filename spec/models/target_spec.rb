# == Schema Information
#
# Table name: targets
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  area_lenght :integer          not null
#  title       :string           not null
#  topic       :integer          not null
#  latitude    :float            not null
#  longitude   :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location    :text
#

require 'rails_helper'

describe Target, type: :model do
  describe 'validations' do
    subject { build(:target) }

    it { is_expected.to validate_presence_of(:area_lenght) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:topic) }
    it {
      is_expected.to define_enum_for(:topic)
        .with_values(football: 0,
                     travel: 1,
                     politics: 2,
                     art: 3,
                     dating: 4,
                     music: 5,
                     movies: 6,
                     series: 7,
                     food: 8)
    }
    it {
      is_expected.to validate_numericality_of(:latitude)
        .is_less_than_or_equal_to(90)
        .is_greater_than_or_equal_to(-90)
    }
    it {
      is_expected.to validate_numericality_of(:longitude)
        .is_less_than_or_equal_to(180)
        .is_greater_than_or_equal_to(-180)
    }
  end

  describe 'associations' do
    subject { create(:target) }

    it { is_expected.to belong_to(:user) }
  end
end
