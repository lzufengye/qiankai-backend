# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  name                        :string(255)
#  image_url                   :string(255)
#  description                 :string(255)
#  price                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  link                        :string(255)
#  hot                         :boolean
#  product_detail_file_name    :string(255)
#  product_detail_content_type :string(255)
#  product_detail_file_size    :integer
#  product_detail_updated_at   :datetime
#  service_file_name           :string(255)
#  service_content_type        :string(255)
#  service_file_size           :integer
#  service_updated_at          :datetime
#  customer_id                 :integer
#  unit                        :string(255)
#  stock_number                :integer
#  free_ship                   :boolean          default(FALSE), not null
#  on_sale                     :boolean          default(FALSE), not null
#  display_order               :integer          default(0), not null
#  cash_on_delivery            :string(255)      default("支持货到付款"), not null
#  sold_number                 :integer          default(0), not null
#

FactoryGirl.define do
  factory :product do
    name                 '测试商品'
    description          '物美价廉'
    price                '123'
    unit                 '个'
    stock_number         20
  end
end
