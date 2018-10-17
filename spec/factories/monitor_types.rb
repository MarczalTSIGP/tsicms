FactoryBot.define do
  factory :monitor_type do
    sequence(:name) { |n| "name#{n}" }
  end
end
