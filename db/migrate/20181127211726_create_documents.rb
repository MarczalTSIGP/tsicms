class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :file
      t.belongs_to :gallery, index: true

      t.timestamps
    end
  end
end
