FactoryBot.define do
  factory :professor_title do
    sequence(:name) { |n| "name#{n}" }
    sequence(:abbrev) { |n| "abbrev#{n}" }
  end
end
