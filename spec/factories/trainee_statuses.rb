FactoryBot.define do
  factory :trainee_status do
    sequence(:name) {|n| "MyString#{n}"}
  end
end
