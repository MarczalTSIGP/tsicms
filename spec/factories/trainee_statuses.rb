FactoryBot.define do
  factory :trainee_status do
    sequence(:description) {|n| "MyString#{n}"}
  end
end
