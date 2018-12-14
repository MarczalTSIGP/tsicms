FactoryBot.define do
  factory :post do
    title { 'A post' }
    description { 'News to the students' }
    posted { false }
    post_category
  end
end
