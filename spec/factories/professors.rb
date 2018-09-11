FactoryBot.define do
  factory :professors do
    @title = ProfessorTitle.first
    @category = ProfessorCategory.first

    sequence(:name) {|n| "Name#{n}"}
    sequence(:lattes) {|n| "lates#{n}"}
    sequence(:occupation_area) {|n| "area de ocupacao #{n}"}
    sequence(:email) {|n| "email#{n}@email.com"}
    professor_title {@title}
    professor_category {@category}
  end
end