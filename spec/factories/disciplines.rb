FactoryBot.define do
  factory :discipline do
    sequence(:name) { |n| "Disciplina #{n}" }
    sequence(:code) { |n| "Code#{n}" }
    sequence(:menu) { |n| "Ementa#{n}" }
    sequence(:initials) { |n| "IN#{n}" }
    theoretical_classes { (30..100).to_a.sample }
    practical_classes { (30..100).to_a.sample }
    distance_classes { (30..100).to_a.sample }
    period
  end
end
