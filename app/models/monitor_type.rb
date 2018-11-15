class MonitorType < ApplicationRecord
  validates :name, presence: true

  has_many :discipline_monitors, dependent: :destroy
  has_many :academics, dependent: :destroy
end
