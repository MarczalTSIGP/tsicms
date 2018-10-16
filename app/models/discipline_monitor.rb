class DisciplineMonitor < ApplicationRecord

  validates :year, presence: true
  validates :semester, presence: true
  validates :description, presence: true
  validates :academic, presence: true
  validates :monitor_type, presence: true

  belongs_to :academic
  belongs_to :monitor_type

  has_many :discipline_monitor_professors
  has_many :professors, through: :discipline_monitor_professors

  accepts_nested_attributes_for :discipline_monitor_professors, :allow_destroy => true
end
