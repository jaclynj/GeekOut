class Tagging < ActiveRecord::Base
  attr_accessible :outings, :tags
  belongs_to :outing
  belongs_to :tag
end
