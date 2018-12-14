FactoryBot.define do
  factory :contact do
    name { 'Contact' }
    sequence(:email) { |n| "visitor#{n}@email.com" }
    phone { '00 00000-0000' }
    message { 'This is my text' }
  end
end
