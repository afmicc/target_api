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

class ContactAdmin < ApplicationRecord
  validates :message, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }

  after_create :send_email_to_admin

  private

  def send_email_to_admin
    AdminMailer.delay.contact(email, message)
  end
end
