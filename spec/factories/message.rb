FactoryBot.define do
  factory :message do
    user
    chat_room
    body { Faker::Lorem.paragraph }
  end
end
