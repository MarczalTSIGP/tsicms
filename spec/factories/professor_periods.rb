FactoryBot.define do
  factory :professor_period do
    date_entry { "2018-01-24" }
    date_out { "2018-10-24" }
    professor { nil }
  end
end
