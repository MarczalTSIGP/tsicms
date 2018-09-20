FactoryBot.define do
  factory :admin do
    name { 'Administrator' }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_image do
      image { FileSpecHelper.image }
    end
  end
end
