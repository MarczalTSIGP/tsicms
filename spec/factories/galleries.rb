FactoryBot.define do
  factory :gallery do
    if %w[course static_page].sample == 'course'
      context_course
    else
      context_static_page
    end

    trait :context_course do
      context { :course }
    end

    trait :context_static_page do
      context { :static_page }
    end

    after :create do |gallery|
      create_list :picture, 3, gallery: gallery
    end
  end
end
