FactoryBot.define do
  factory :academic do
    name { 'name' }
    contact { 'https://www.google.com' }
    graduated { false }

    image { FileSpecHelper.image }
  end
end
