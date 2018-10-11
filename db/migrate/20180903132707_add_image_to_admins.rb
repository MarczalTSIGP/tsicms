class AddImageToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :image, :string
  end
end
