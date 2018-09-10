FactoryBot.define do
  factory :professor_category do
    sequence(:name) { |n| "desc#{n}" }
  end
end
