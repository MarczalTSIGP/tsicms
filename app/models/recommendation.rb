class Recommendation < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true

  belongs_to :category_recommendation

  has_one_attached :image
end
