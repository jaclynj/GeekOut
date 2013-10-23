class AddMoreDateFields < ActiveRecord::Migration
  def up
    add_column :places, :end_date, :date
    add_column :places, :end_time, :date
  end

  def down
  end
end
