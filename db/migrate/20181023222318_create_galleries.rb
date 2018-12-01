class CreateGalleries < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE gallery_contexts AS ENUM ('course', 'static_page');
    SQL

    create_table :galleries do |t|
      t.column :context, :gallery_contexts
      t.timestamps
    end

    add_index :galleries, :context, unique: true
  end

  def down
    drop table :galleries

    execute <<-SQL
      DROP TYPE gallery_contexts;
    SQL
  end
end
