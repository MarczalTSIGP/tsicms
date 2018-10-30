class PeriodProfessor < ApplicationRecord
  belongs_to :professor

  validates :date_entry, presence: true
  validates :professor, presence: true

end
