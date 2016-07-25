# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  receiver      :string(255)
#  phone         :string(255)
#  address       :string(255)
#  city_name     :string(255)
#  province_name :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  consumer_id   :integer
#  is_default    :boolean          default(FALSE), not null
#  deleted       :boolean          default(FALSE), not null
#  province_id   :integer
#  city_id       :integer
#

class Address < ActiveRecord::Base
  belongs_to :consumer
  has_many :orders

  def human_read_address
    "收件人:#{receiver}, 电话:#{phone}, 详细地址: #{address}, 城市: #{city_name || (city_id.present? ? City.find(city_id).try(:name) : '')}, 省份: #{province_name || (province_id.present? ? Province.find(province_id).try(:name) : '')}"
  end

  def receiver_address_detail
    "#{province_name || (province_id.present? ? Province.find(province_id).try(:name) : '')} #{city_name || (city_id.present? ? City.find(city_id).try(:name) : '')} #{address}"
  end
end
