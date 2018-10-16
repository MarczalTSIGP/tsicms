class Professor < ApplicationRecord
  validates :name, presence: true
  validates :lattes, presence: true, format: { with: URI.regexp }
  validates :occupation_area, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }

  validates :professor_title, presence: true
  validates :professor_category, presence: true

  belongs_to :professor_title
  belongs_to :professor_category

  has_many :discipline_monitor_professors
  has_many :discipline_monitors, through: :discipline_monitor_professors
end
