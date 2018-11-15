FactoryBot.define do
  factory :discipline do
    sequence(:name) { |n| "Disciplina #{n}" }
    sequence(:code) { |n| "Code#{n}" }
    sequence(:menu) { |n| "Ementa#{n}" }
    hours { (30..100).to_a.sample }
    period
  end
end
