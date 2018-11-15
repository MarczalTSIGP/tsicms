FactoryBot.define do
  factory :activity do
    sequence(:name) {|n| "ActivityName#{n}"}
    sequence(:description) {|n| "ActivityDescription #{n}"}

    trait :with_trainee do
      name {I18n.t('helpers.trainee')}
    end
    trait :with_tcc do
      name {I18n.t('helpers.tcc')}
    end
    trait :with_monitor do
      name {I18n.t('helpers.monitor')}
    end
  end
end
