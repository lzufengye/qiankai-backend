# == Schema Information
#
# Table name: order_groups
#
#  id         :integer          not null, primary key
#  order_sns  :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

class OrderGroup < ActiveRecord::Base
  def orders
    order_sns.split(',').map(&:strip).map {|sn| Order.find_by_sn(sn)}
  end
end
