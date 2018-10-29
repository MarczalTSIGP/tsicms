class TraineeStatus < ApplicationRecord
  validates :name, presence: true

  has_many :trainees, dependent: :restrict_with_error
end
