FactoryBot.define do
  factory :category_recommendation do
    sequence(:name) { |n| "Categoria_#{n}" }
  end
end
