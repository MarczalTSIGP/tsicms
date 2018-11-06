class CreateDisciplineMonitors < ActiveRecord::Migration[5.2]
  def change
    create_table :discipline_monitors do |t|
      t.integer :year
      t.integer :semester
      t.text :description

      t.belongs_to :academic, index: true, foreign_key: true
      t.belongs_to :monitor_type, index: true, foreign_key: true

      t.timestamps
    end
  end
end
