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

FactoryGirl.define do
  factory :address do
    receiver                 'test_receiver'
    phone                    '13952136920'
    address                  '高新区绵兴东路119号'
    city_name                '渝中区'
    province_name            '重庆市'
    province_id              1
    city_id                  2
  end
end
