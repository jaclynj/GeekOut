class Tagging < ActiveRecord::Base
  attr_accessible :places, :tags
  belongs_to :place
  belongs_to :tag
end
