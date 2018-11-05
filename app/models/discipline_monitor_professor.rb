class DisciplineMonitorProfessor < ApplicationRecord
    belongs_to :professor
    belongs_to :discipline_monitor

    accepts_nested_attributes_for :professor, reject_if: :all_blank, allow_destroy: true
end
