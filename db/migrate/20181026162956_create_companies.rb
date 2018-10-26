class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :operation
      t.string :site
      t.string :image

      t.timestamps
    end
  end
end
