class EditsToPlaceNotNullAgainAgain < ActiveRecord::Migration
  def up
    change_column :places, :name, :string, default: nil, null: false
  end

  def down
  end
end
