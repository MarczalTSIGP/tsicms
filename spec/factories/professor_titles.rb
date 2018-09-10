FactoryBot.define do
  factory :professor_title do
    sequence(:description) { |n| "desc#{n}" }
    sequence(:abbrev) { |n| "abbrev#{n}" }
  end
end
