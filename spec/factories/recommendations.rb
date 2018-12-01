FactoryBot.define do
  factory :recommendation do
    title { 'Recommendation Title' }
    description { 'Recommendation description' }
    image { FileSpecHelper.image }
    category_recommendation
  end
end
