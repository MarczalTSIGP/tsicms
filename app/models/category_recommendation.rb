class CategoryRecommendation < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :recommendations, dependent: :destroy
end
