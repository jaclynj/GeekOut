class Place < ActiveRecord::Base
  attr_accessible :name, :date, :start_time, :sponsor, :location, :venue_address, :description, :link, :tags, :end_time, :end_date, :taggings
  has_many :taggings
  has_many :tags, through: :taggings
  validates :name, presence: true

  def tag!(new_tags)
    tags = new_tags.split(",").map do |t|
      t = t.strip
      Tag.find_or_create_by_name(t)
    end
    self.tags << tags
  end

  def pretty_time
    self.date.strftime("%A, %B %e, %Y")
  end

end
