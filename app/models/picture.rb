class Picture < ApplicationRecord
  validates :image, presence: true
  belongs_to :gallery

  mount_uploader :image, PictureImageUploader
end
