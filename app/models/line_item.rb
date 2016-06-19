# == Schema Information
#
# Table name: line_items
#
#  id                :integer          not null, primary key
#  order_id          :integer
#  product_id        :integer
#  quantity          :integer
#  unit_price        :float(24)
#  state             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  handle_state      :string(255)      default("未处理"), not null
#  logistical        :string(255)
#  logistical_number :string(255)
#  sku_id            :integer
#

class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :sku
  has_one :customer, through: :product
end
