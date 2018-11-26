FactoryBot.define do
  factory :static_page do
    sequence(:title) {|n| "title#{n}"}
    sequence(:sub_title) {|n| "sub_title#{n}"}
    sequence(:content) {|n| "content#{n}"}
    fixed {false}
    sequence(:permalink) {|n| "Permalink_#{n}"}

    trait :with_activity do
      activity
    end
  end
end
