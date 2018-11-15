class Trainee < ApplicationRecord

  belongs_to :company
  belongs_to :trainee_status

  validates :company, presence: true
  validates :trainee_status, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
