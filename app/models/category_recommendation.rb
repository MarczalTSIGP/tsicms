class CategoryRecommendation < ApplicationRecord
  validates :name, presence: true
  has_many :recommendations
end
