FactoryBot.define do
  factory :activity_professor do
    professor
    activity
    start_date {"2018-10-01 21:46:22"}
    end_date {"2018-10-01 21:46:22"}

    trait :with_trainee do
      association :activity, factory: :activity, :traits => [:with_trainee]
    end
    trait :with_tcc do
      association :activity, factory: :activity, :traits => [:with_tcc]
    end
    trait :with_monitor do
      association :activity, factory: :activity, :traits => [:with_monitor]
    end
  end
end
