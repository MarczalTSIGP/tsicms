FactoryBot.define do
  factory :trainee do
    sequence(:title) {|n| "MyString#{n}"}
    sequence(:description) {|n| "MyString#{n}"}
    company
    trainee_status
  end
end
