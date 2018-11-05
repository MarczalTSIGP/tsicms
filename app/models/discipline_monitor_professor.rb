class DisciplineMonitorProfessor < ApplicationRecord
    belongs_to :professor
    belongs_to :discipline_monitor
end
