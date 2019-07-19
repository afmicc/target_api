# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string           not null
#  nickname               :string
#  image                  :string
#  email                  :string           not null
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  gender                 :integer          not null
#

require 'rails_helper'

describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:uid).case_insensitive.scoped_to(:provider) }
  it { is_expected.to validate_presence_of(:gender) }
  it { is_expected.to define_enum_for(:gender).with_values(male: 0, female: 1) }
  it { is_expected.to have_many(:targets) }
end
