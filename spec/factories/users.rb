# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    password_confirmation { |user| user.password }
    active false

    trait :inactive do
      active false
    end
    trait :active do
      active true
    end
    trait :with_searches do
      searches { FactoryGirl.create_list(:search, 5) }
    end
  end
end
