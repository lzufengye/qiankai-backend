# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  consumer_id         :integer
#  address_id          :integer
#  state               :string(255)
#  total_price         :float(24)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ship_fee            :float(24)
#  sn                  :string(255)
#  logistical          :string(255)
#  logistical_number   :string(255)
#  handle_state        :string(255)      default("未处理"), not null
#  deleted             :boolean          default(FALSE), not null
#  comment             :text(65535)
#  invoice_title       :string(255)
#  payment_method_id   :integer
#  payment_method_name :string(255)
#  customer_id         :integer
#

class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products, through: :line_items
  has_many :customers, through: :line_items

  belongs_to :consumer
  belongs_to :address
  belongs_to :payment_method
  belongs_to :customer

  def need_to_be_charged
    total_price.to_f + ship_fee.to_f
  end

  def paid?
    state == '已支付'
  end
end
