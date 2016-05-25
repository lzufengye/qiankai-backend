# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  consumer_id       :integer
#  address_id        :integer
#  state             :string(255)
#  total_price       :float(24)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  ship_fee          :float(24)
#  sn                :string(255)
#  logistical        :string(255)
#  logistical_number :string(255)
#  handle_state      :string(255)      default("未处理"), not null
#  deleted           :boolean          default(FALSE), not null
#  comment           :text(65535)
#

class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products, through: :line_items
  has_many :customers, through: :line_items

  belongs_to :consumer
  belongs_to :address
end
