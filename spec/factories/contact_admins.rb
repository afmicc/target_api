# == Schema Information
#
# Table name: contact_admins
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  message    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :contact_admin do
    email { Faker::Internet.email('User') }
    message { Faker::Lorem.paragraph }
  end
end
