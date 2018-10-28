class CreateTraineeStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :trainee_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end
