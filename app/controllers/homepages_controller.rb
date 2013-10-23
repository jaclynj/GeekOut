class HomepagesController < ApplicationController

  def view
  end

  def results
    #filters by tags
    tag_filter = params[:tag]
    @filtered_by_tag = []
    @filtered_multiple_tags = []
    @filtered_at_least_one_tag = []

    if tag_filter != nil
      tag_filter.each do |f|
        @filtered_by_single_tag = Tagging.where({tag_id: f})
        @filtered_by_single_tag.each do |t|
          id = t.place_id
          @filtered_by_single_tag = Place.find_by_id(id)
          @filtered_by_tag << @filtered_by_single_tag
        end
      end
    end
    #filters by location
    city = params[:location]
    if city == 'Any City'
    else
      @filtered_by_location = Place.where({location: city})
      if @filtered_by_location != []
        @filtered_by_tag.each do |outing|
          if @filtered_by_location.include?(outing)
          else
            @filtered_by_tag.delete(outing)
          end
        end
      end
    end
    #contains outings matching at least one tag & multiple tags
    @filtered_at_least_one_tag = @filtered_by_tag.uniq
    @filtered_multiple_tags = @filtered_by_tag.select{|p| @filtered_by_tag.count(p) > 1}
    @filtered_multiple_tags.uniq!
  end

end
