class ProfessorTitle < ApplicationRecord
  validates :description, presence: true
  validates :abbrev, presence: true

  has_many :professors, dependent: :destroy
end
