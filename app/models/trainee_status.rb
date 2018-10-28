class TraineeStatus < ApplicationRecord
  validates :description, presence: true

  has_many :trainees, dependent: :restrict_with_error
end
