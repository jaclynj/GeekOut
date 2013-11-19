class RenamePlaceIdColumnInTaggingRelationTable < ActiveRecord::Migration
  def change
    rename_column :taggings, :place_id, :outing_id
  end

  def down
  end
end
