class Post < ApplicationRecord
  belongs_to :post_category

  validates :title, presence: true
  validates :description, presence: true
  validates :posted, presence: false
  validates :post_category, presence: true
end
