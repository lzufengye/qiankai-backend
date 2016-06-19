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
