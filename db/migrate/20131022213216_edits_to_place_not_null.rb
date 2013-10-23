class EditsToPlaceNotNull < ActiveRecord::Migration
  def up
    change_column_null(:places, :name, false)
  end

  def down
  end
end
