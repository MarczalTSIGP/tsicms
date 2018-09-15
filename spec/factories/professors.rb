FactoryBot.define do
  factory :professor do

    sequence(:name) {|n| "Name#{n}"}
    sequence(:lattes) {|n| "lates#{n}"}
    sequence(:occupation_area) {|n| "area de ocupacao #{n}"}
    sequence(:email) {|n| "email#{n}@email.com"}
    professor_title
    professor_category
  end
end