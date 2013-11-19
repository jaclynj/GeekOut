class Tag < ActiveRecord::Base
  attr_accessible :name, :outings
  has_many :taggings
  has_many :outings, through: :taggings

  def current_outings
    self.outings.where("date >= ?", Date.today)
  end

end
