class HomepagesController < ApplicationController

def view
end

  def results
    filter = params[:tag]
    @filtered = []
    @filtered_multiple_tags = []
    @filtered_at_least_one_tag = []
    if filter != nil
      filter.each do |f|
        @this_tag = Tagging.where({tag_id: f})
        @this_tag.each do |t|
          id = t.place_id
          @filtered_place = Place.find_by_id(id)
          @filtered << @filtered_place
        end
      end
     @filtered_at_least_one_tag = @filtered.uniq
     @filtered_multiple_tags = @filtered.select{|p| @filtered.count(p) > 1}
     @filtered_multiple_tags.uniq!
   end
end

end
