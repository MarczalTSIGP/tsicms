class PeriodProfessor < ApplicationRecord
  validates :date_entry, presence: true
  validates :professor, presence: true

  belongs_to :professor
end
