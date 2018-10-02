class Activity < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true

  has_many :activity_professors
  has_many :professors, :through => :activity_professors
end
