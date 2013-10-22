class CreateRelationsTable < ActiveRecord::Migration
  def up
    create_table :taggings, id: false do |t|
      t.integer :tag_id
      t.integer :place_id
      t.timestamps
    end
  end

  def down
    drop_table :taggings
  end
end
