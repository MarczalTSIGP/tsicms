class ProfessorTitle < ApplicationRecord
  validates :name, :abbrev, presence: true, uniqueness: { case_sensitive: false }

  has_many :professors, dependent: :destroy
end
