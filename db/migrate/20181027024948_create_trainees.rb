class CreateTrainees < ActiveRecord::Migration[5.2]
  def change
    create_table :trainees do |t|
      t.string :title
      t.text :description
      t.belongs_to :company, index: true, foreign_key: true
      t.belongs_to :trainee_status, index: true, foreign_key: true

      t.timestamps
    end
  end
end
