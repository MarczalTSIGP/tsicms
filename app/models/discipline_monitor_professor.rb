class DisciplineMonitorProfessor < ApplicationRecord
    validates :professor, presence: true
    validates :discipline_monitor, presence: true

    belongs_to :professor
    belongs_to :discipline_monitor

    accepts_nested_attributes_for :professor, reject_if: :all_blank, allow_destroy: true

end
