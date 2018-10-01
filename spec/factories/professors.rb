FactoryBot.define do
  factory :professor do
    sequence(:name) {|n| "Name#{n}"}
    sequence(:lattes) {|n| "http://lattes.com.#{n}"}
    sequence(:occupation_area) {|n| "Artificial Inteligence #{n}"}
    sequence(:email) {|n| "email#{n}@email.com"}
    professor_title
    professor_category
  end
end
