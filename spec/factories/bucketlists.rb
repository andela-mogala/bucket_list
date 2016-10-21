FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Commerce.product_name }
    user
  end
end
