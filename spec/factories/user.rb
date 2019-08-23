FactoryBot.define do
  factory :user, aliases: %i[user_owner user_guest] do
    name { Faker::Name.name }
    email  { Faker::Internet.email('User') }
    password { Faker::Internet.password(10, 20) }
    gender { User.genders.values.sample }

    trait :confirmed do
      confirmed_at { Faker::Date.backward(4) }
    end

    trait :with_targets do
      transient do
        targets_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:target, evaluator.targets_count, user: user)
      end
    end

    trait :with_avatar do
      after(:create) do |user|
        user.avatar.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'small_avatar.png')),
          filename: 'small_avatar.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
