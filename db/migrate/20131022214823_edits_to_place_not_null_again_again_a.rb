class EditsToPlaceNotNullAgainAgainA < ActiveRecord::Migration
  def up
    change_column :places, :name, :string, default: "", null: false
  end

  def down
  end
end
