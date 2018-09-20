FactoryBot.define do
  factory :recommendation do
    title { 'Recommendation Title' }
    description { 'Recommendation description' }
    category_recommendation

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
