class Activity < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :activity_professors, dependent: :restrict_with_error
  has_many :professors, through: :activity_professors

  has_one :static_page
  def current_responsible
    self.activity_professors.find_by(end_date: nil).professor
  end
end
