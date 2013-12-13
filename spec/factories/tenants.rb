FactoryGirl.define do
  factory :tenant do
    name { Faker::Company.name }
  end
end
