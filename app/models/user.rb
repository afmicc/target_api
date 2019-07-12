# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string           not null
#  nickname               :string
#  image                  :string
#  email                  :string           not null
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :trackable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, # :rememberable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]
  include DeviseTokenAuth::Concerns::User
  # devise :omniauthable

  validates :name, :email, presence: true
  validates :uid, uniqueness: { case_sensitive: false, scope: :provider }

  # def self.create_from_omniauth(auth)
  #   byebug
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.image = auth.info.image # assuming the user model has an image
  #     user.token = auth.credentials.token
  #     # If you are using confirmable and the provider(s) you use validate emails,
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end
  # end
end
