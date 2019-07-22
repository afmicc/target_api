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

FactoryBot.define do
  factory :general_information do
    key { Faker::Lorem.word }
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
  end
end
