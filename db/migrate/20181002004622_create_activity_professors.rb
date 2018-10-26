class CreateActivityProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_professors do |t|
      t.belongs_to :professor, index: true
      t.belongs_to :activity, index: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
