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
#  gender                 :integer          not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  enum gender: { male: 0, female: 1 }

  has_many :targets, dependent: :destroy
  has_many :own_chat_rooms, class_name: :ChatRoom, foreign_key: 'user_owner_id'
  has_many :guest_chat_rooms, class_name: :ChatRoom, foreign_key: 'user_guest_id'
  has_many :messages, dependent: :destroy
  has_one_base64_attached :avatar

  validates :name, :email, presence: true
  validates :uid, uniqueness: { case_sensitive: false, scope: :provider }
  validates :gender, presence: true, inclusion: { in: genders.keys }

  def chat_rooms
    own_chat_rooms.or(guest_chat_rooms)
  end
end
