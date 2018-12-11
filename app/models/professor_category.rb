class ProfessorCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :professor_periods, dependent: :destroy
end
