FactoryBot.define do
  factory :admin do
    name { 'Administrator' }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_image do
<<<<<<< HEAD
      image { FileSpecHelper.image }
    end
=======
      image { File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample) }
    end  
>>>>>>> Feature to create academic
  end
end
