class CreateDisciplineMonitorDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :discipline_monitor_disciplines do |t|
      t.integer :discipline_id
      t.integer :discipline_monitor_id

      t.timestamps
    end
  end
end
