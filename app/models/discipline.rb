class Discipline < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :code, presence: true, uniqueness: true
  validates :hours, presence: true, numericality: { only_integer: true }
  belongs_to :period
end
