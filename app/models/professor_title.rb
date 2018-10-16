class ProfessorTitle < ApplicationRecord
  validates :name, :abbrev, presence: true, uniqueness: { case_sensitive: false }

  has_many :professors, dependent: :delete_all
end
