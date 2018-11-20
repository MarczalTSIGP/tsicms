FactoryBot.define do
  factory :activity_professor do
    professor
    activity
    start_date {"2018-10-01 21:46:22"}
    end_date {"2018-10-01 21:46:22"}

    trait :with_trainee do
      association :activity, factory: [:activity, :with_trainee]
    end
    trait :with_trainee_current do
      association :activity, factory: [:activity, :with_trainee]
      end_date {nil}
    end
    trait :with_tcc do
      association :activity, factory: [:activity, :with_tcc]
    end
    trait :with_tcc_current do
      association :activity, factory: [:activity, :with_tcc]
      end_date {nil}
    end
    trait :with_monitor do
      association :activity, factory: [:activity, :with_monitor]
    end
    trait :with_monitor_current do
      association :activity, factory: [:activity, :with_monitor]
      end_date {nil}
    end
  end
end
