FactoryBot.define do
  factory :document do
    file { FileSpecHelper.pdf }
    gallery
  end
end
