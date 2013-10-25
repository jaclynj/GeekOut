class Tag < ActiveRecord::Base
  attr_accessible :name, :places
  has_many :taggings
  has_many :places, through: :taggings

  def current_places
    self.places.where("date >= ?", Date.today)
  end

end
