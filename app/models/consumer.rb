# == Schema Information
#
# Table name: consumers
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string(255)
#  user_name              :string(255)
#  phone                  :string(255)
#  provider               :string(255)
#  openid                 :string(255)
#  nickname               :string(255)
#  sex                    :integer
#  city                   :string(255)
#  province               :string(255)
#  headimgurl             :string(255)
#  refresh_token          :string(255)
#

class Consumer < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :phone, if: lambda{ |object| object.phone.present? }

  has_many :orders
  has_many :addresses
end
