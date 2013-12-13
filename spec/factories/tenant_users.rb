# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tenant_user do
    association :user
    association :tenant
  end
end
