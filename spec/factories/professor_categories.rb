FactoryBot.define do
  factory :professor_category do
    sequence(:name) { |n| "name#{n}" }
  end
end
