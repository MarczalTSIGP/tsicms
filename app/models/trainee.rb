class Trainee < ApplicationRecord
  belongs_to :company
  belongs_to :trainee_statuses

  validates :company, presence: true
  validates :trainee_statuses, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
