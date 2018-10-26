FactoryBot.define do
  factory :academic do
    sequence(:name) { |n| "name #{n}" }
    contact { 'https://www.google.com' }
    graduated { false }

    image { FileSpecHelper.image }
  end
end
