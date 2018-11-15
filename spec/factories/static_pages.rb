FactoryBot.define do
  factory :static_page do
    title {'title'}
    sub_title {'sub_title'}
    content {'content'}
    fixed {false}
    sequence(:permalink) {|n| "Permalink_#{n}"}

    trait :with_trainee do
      title {I18n.t('helpers.trainee')}
    end
    trait :with_tcc do
      title {I18n.t('helpers.tcc')}
    end
    trait :with_monitor do
      title {I18n.t('helpers.monitor')}
    end
  end
end
