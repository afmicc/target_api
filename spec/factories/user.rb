FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email('User') }
    password { Faker::Internet.password(10, 20) }
  end
end
