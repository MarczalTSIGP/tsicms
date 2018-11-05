class ProfessorCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :period_professors, dependent: :destroy
end
