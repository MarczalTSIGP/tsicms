class CreateDisciplineMonitorProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :discipline_monitor_professors do |t|

      t.integer :professor_id
      t.integer :discipline_monitor_id

      t.timestamps
    end
  end
end
