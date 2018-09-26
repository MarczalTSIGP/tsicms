FactoryBot.define do
  factory :academic do
    sequence(:name) { |n| "Joao_#{n}" }
    contact { 'https://www.google.com' }
    graduated { false }

    #trait :with_image do
      image { FileSpecHelper.image }
    #end
  end
end
