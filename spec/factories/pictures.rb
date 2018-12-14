FactoryBot.define do
  factory :picture do
    label { 'MyString' }
    image { FileSpecHelper.image }
    gallery
  end
end
