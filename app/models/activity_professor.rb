class ActivityProfessor < ApplicationRecord

  validates :start_date, presence: true
  validates :professor, presence: true
  validates :activity, presence: true

  belongs_to :professor
  belongs_to :activity
end
