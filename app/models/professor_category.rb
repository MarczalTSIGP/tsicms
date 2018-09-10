class ProfessorCategory < ApplicationRecord
  validates :name, presence: true

  has_many :professors, dependent: :destroy
end
