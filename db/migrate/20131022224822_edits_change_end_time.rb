class EditsChangeEndTime < ActiveRecord::Migration
  def up
    change_column :places, :end_time, :string
  end

  def down
  end
end
