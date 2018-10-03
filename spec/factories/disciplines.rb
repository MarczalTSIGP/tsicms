FactoryBot.define do
  factory :discipline do
    sequence(:name) {|n| "Disciplina #{n}"}
    sequence(:code) {|c| "Code#{c}"}
    hours {100}

    period
  end
end
