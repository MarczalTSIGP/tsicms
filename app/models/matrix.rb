class Matrix < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :periods, dependent: :destroy
end
