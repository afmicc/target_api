FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email('User') }
    password { Faker::Internet.password(10, 20) }
    gender { User.genders.values.sample }

    trait :confirmed do
      confirmed_at { Faker::Date.backward(4) }
    end

    transient do
      targets_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:target, evaluator.targets_count, user: user)
    end
  end
end
