FactoryBot.define do
  factory :academic do
    name { Faker::Name.name }
    contact { Faker::Internet.url }
    graduated { false }
  end
end
