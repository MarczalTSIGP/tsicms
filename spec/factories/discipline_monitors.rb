FactoryBot.define do
  factory :discipline_monitor do
    academic
    monitor_type
    year { 2018 }
    semester { [1,2].sample }
    description { "MyText" }
  end
end
