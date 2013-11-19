class RenamePlacesTableToOutings < ActiveRecord::Migration
  def change
    rename_table :places, :outings
  end

  def down
  end
end
