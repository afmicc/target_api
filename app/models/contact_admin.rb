class ContactAdmin < ActiveRecord::Base
  validates :message, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }

  after_create :send_email_to_admin

  private

  def send_email_to_admin
    AdminMailer.delay.contact(email, message)
  end
end
