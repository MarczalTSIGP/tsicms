class Trainee < ApplicationRecord
  max_paginates_per 2

  belongs_to :company
  belongs_to :trainee_status

  validates :company, presence: true
  validates :trainee_status, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
