FactoryBot.define do
  factory :gallery do
    context { %w[course static_page].sample }

    after :create do |gallery|
      create_list :picture, 3, gallery: gallery
    end
  end
end
