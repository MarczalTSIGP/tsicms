FactoryBot.define do
  factory :recommendation do
    category_recommendation { CategoryRecommendation.all.sample || association(:category_recommendation) }
    title { 'Recommendation Title' }
    description { 'Recommendation description' }
    image { Rails.root.join('app', 'assets', 'images', 'logo-tsi-text.png') }
  end
end
