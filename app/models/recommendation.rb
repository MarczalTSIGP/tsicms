class Recommendation < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :category_recommendation

  mount_uploader :image, RecommendationImageUploader
end
