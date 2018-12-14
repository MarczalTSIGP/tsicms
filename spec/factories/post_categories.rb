FactoryBot.define do
  factory :post_category do
    sequence(:name) { |n| "Categoria_#{n}" }
  end
end
