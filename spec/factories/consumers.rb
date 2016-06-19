FactoryGirl.define do
  factory :consumer do
    email                 'test@tests.com'
    phone                 '13952136920'
    password              '123456789'
    password_confirmation '123456789'

    trait :with_address do
      after(:create) do |consumer|
        create_list(:address, 1, consumer: consumer)
      end
    end
  end
end
