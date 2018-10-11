FactoryBot.define do
  factory :professor do
    sequence(:name) {|n| "Name#{n}"}
    choose(:gender)
    sequence(:lattes) {|n| "http://lattes.com.#{n}"}
    sequence(:occupation_area) {|n| "Artificial Inteligence #{n}"}
    sequence(:email) {|n| "email#{n}@email.com"}
    professor_title
    professor_category
    image { FileSpecHelper.image }
  end
end
