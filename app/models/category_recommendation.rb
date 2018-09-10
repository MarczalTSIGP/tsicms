class CategoryRecommendation < ApplicationRecord
  validates :name, presence: true
  has_many :recommendation
end
