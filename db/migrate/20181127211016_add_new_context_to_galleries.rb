class AddNewContextToGalleries < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    execute <<-SQL
      ALTER TYPE gallery_contexts ADD VALUE IF NOT EXISTS 'document' AFTER 'static_page';
    SQL
  end
end
