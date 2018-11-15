FactoryBot.define do
  factory :trainee_status do
    sequence(:name) { |n| "TraineeName#{n}" }
  end
end
