# == Schema Information
#
# Table name: shopping_carts
#
#  id          :integer          not null, primary key
#  consumer_id :integer
#  product_id  :integer
#  sku_id      :integer
#  quantity    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ShoppingCart < ActiveRecord::Base
end
