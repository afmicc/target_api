# == Schema Information
#
# Table name: general_informations
#
#  id         :bigint           not null, primary key
#  key        :string           not null
#  title      :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GeneralInformation < ActiveRecord::Base
  validates :title, :text, presence: true
  validates :key, presence: true, uniqueness: { case_sensitive: false }
end
