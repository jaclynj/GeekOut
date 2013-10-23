class EditsToPlaceNotNullAgain < ActiveRecord::Migration
  def up
    change_column :places, :name, :string, default: "n/a", null: false
  end

  def down
  end
end
