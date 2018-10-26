class CreatePeriods < ActiveRecord::Migration[5.2]

  def change
    create_table :periods do |t|
      t.string :name
      t.references :matrix, foreign_key:true
      
      t.timestamps
    end
  end

end
