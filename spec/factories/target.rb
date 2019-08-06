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

FactoryBot.define do
  factory :target do
    user
    area_lenght { Faker::Number.between(1, 1000) }
    title { Faker::Lorem.word }
    topic { Target.topics.keys.sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
