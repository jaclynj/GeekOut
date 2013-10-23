class EditsToPlaceTable < ActiveRecord::Migration
  def up
    change_column :places, :name, :string, null:false
  end

  def down
  end
end
