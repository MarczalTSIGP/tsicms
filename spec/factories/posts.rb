FactoryBot.define do
  factory :post do
    title { 'A post' }
    description { 'News to the students' }
    posted { [true, false].sample }
    post_category
  end
end
