FactoryBot.define do
  factory :professor_genre do
    sequence(:name) { |n| "name#{n}" }
  end
end
