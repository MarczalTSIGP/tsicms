FactoryBot.define do
  factory :period do
    sequence(:name) {|n| "Periodo #{n}"}
    matrix
    
  end
end
