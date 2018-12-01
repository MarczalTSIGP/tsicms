FactoryBot.define do
  factory :trainee do
    sequence(:title) { |n| "TraineeTitle#{n}" }
    sequence(:description) { |n| "TraineDescription#{n}" }
    company
    trainee_status
  end
end
