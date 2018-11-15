FactoryBot.define do
  factory :professor do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:lattes) { |n| "http://lattes.com.#{n}" }
    sequence(:occupation_area) { |n| "Artificial Inteligence #{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    image { FileSpecHelper.image }
    gender { Professor.genders.values.sample }
    professor_title
    professor_category
  end
end
