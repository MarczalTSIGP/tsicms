FactoryBot.define do
  factory :static_page do
    title {'title'}
    sub_title {'sub_title'}
    content {'content'}
    fixed {false}
    sequence(:permalink) {|n| "Permalink_#{n}"}
  end
end
