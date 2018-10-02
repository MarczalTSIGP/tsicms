FactoryBot.define do
  factory :activity do
    sequence(:name) {|n| "name#{n}"}
    sequence(:description) {|n| "description #{n}"}
  end
end
