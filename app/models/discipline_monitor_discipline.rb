class DisciplineMonitorDiscipline < ApplicationRecord
    belongs_to :discipline
    belongs_to :discipline_monitor

    accepts_nested_attributes_for :discipline, reject_if: :all_blank, allow_destroy: true
end

