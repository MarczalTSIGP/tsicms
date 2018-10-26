FactoryBot.define do
  factory :faq do
    sequence(:title) { |n| "Nova_duvida_#{n}" }
    sequence(:answer) { |n| "Nova_resposta_#{n}" }
  end
end
