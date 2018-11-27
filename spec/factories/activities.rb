FactoryBot.define do
  factory :activity do
    sequence(:name) { |n| "ActivityName#{n}" }
    sequence(:description) { |n| "ActivityDescription #{n}" }
  end
end
