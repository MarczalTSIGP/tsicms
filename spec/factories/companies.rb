FactoryBot.define do
  factory :company do
    sequence(:name) {|n| "CompanyName#{n}"}
    sequence(:operation) {|n| "Operation#{n}"}
    sequence(:site) {|n| "http://site#{n}.com"}
    image {FileSpecHelper.image}
  end
end
