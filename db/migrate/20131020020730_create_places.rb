class CreatePlaces < ActiveRecord::Migration
  def up
      create_table :places do |t|
      t.string :name
      t.date :date
      t.string :start_time
      t.string :sponsor
      t.string :location
      t.string :venue_address
      t.string :description
      t.string :link
      t.timestamps
    end
  end

  def down
  end
end
