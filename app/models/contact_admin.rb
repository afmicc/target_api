class ContactAdmin < ActiveRecord::Base
  validates :message, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
end
