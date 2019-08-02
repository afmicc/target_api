FactoryBot.define do
  factory :chat_room do
    user_owner
    user_guest
    unread_messages_guest { Faker::Number.digit }
    unread_messages_owner { Faker::Number.digit }
    target_owner
    target_guest

    trait :with_messages do
      transient do
        messages_count { 5 }
      end

      after(:create) do |chat_room, evaluator|
        create_list(:message, evaluator.messages_count, chat_room: chat_room)
      end
    end
  end
end
