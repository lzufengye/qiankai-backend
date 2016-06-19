# == Schema Information
#
# Table name: customers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  phone       :string(255)
#

class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_many :admin_users
  accepts_nested_attributes_for :admin_users, allow_destroy: true

  has_many :products
  has_many :orders
end
