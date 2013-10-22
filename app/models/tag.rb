class Tag < ActiveRecord::Base
  attr_accessible :name, :places
  has_many :taggings
  has_many :places, through: :taggings
end
