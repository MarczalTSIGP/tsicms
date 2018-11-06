class PeriodProfessor < ApplicationRecord
  belongs_to :professor
  belongs_to :professor_category

  validates :date_entry, presence: true
  

end
