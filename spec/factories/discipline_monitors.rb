FactoryBot.define do
  factory :discipline_monitor do
    academic
    monitor_type
    year { 2018 }
    semester { "1º" }
    description { "MyText" }
  end
end
