# == Schema Information
#
# Table name: targets
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  area_lenght :integer          not null
#  title       :string           not null
#  topic       :integer          not null
#  latitude    :decimal(10, 6)   not null
#  longitude   :decimal(10, 6)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :target do
    user
    area_lenght { Faker::Number.between(1, 1000) }
    title { Faker::Lorem.word }
    topic { Target.topics.values.sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
