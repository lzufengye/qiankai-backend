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
#  qq_number   :string(255)
#

FactoryGirl.define do
  factory :customer do
    name                 '重庆康园自行车有限公司'
    phone                '13952136920'

    trait :with_products do
      after(:create) do |customer|
        create_list(:product, 5, customer: customer)
      end
    end
  end
end
