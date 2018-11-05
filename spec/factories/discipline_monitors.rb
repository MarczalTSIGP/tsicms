FactoryBot.define do
  factory :discipline_monitor do
    year { 2018 }
    semester { [1,2].sample }
    description { "MyText" }

    academic
    monitor_type

    after(:build) do |dm|
      dm.professors << create(:professor)
      dm.professors << create(:professor)
      dm.disciplines << create(:discipline)
    end
  end
end
