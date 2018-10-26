class Company < ApplicationRecord
  validates :name, presence: true
  validates :site, presence: true
  validates :operation, presence: true
  validates :image, presence: true
end
