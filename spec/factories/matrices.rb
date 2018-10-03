

FactoryBot.define do
  factory :matrix do
    sequence(:name) {|n| "Matriz #{n}"}
  end
end
