FactoryBot.define do
  factory :academic do
    name { 'José Teste' }
    contact { 'https://www.google.com' }
    graduated { false }

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
