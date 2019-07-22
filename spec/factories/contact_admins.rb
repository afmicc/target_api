FactoryBot.define do
  factory :contact_admin do
    email { Faker::Internet.email('User') }
    message { Faker::Lorem.paragraph }
  end
end
