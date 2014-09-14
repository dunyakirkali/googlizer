# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :search do
    query { Faker::Name.title }
    hits { Faker::Number.number(3) }
  end
end
