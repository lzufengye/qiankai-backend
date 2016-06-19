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
