class HomepagesController < ApplicationController

  def view
  end

  def results
    #filters by tags
    tag_filter = params[:tag]
    @filtered_by_tag = []
    @filtered_multiple_tags = []
    @filtered_at_least_one_tag = []

    # OPTIMIZE with where statement so that you don't have to do multiple database calls
    # there shoudl only be 1 call to where
    # Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight, tag1 or tag 2 or tag 3, order_by: "desc")

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
    @city = params[:location]
    if @city == 'Any City'
    else
      @filtered_by_location = Place.where({location: @city})
      if @filtered_by_location != []
        @filtered_by_tag.each do |outing|
          if @filtered_by_location.include?(outing)
          else
            @filtered_by_tag.delete(outing)
          end
        end
      end
    end
    #sorts by date
    @filtered_by_tag = (@filtered_by_tag.sort {|a,b| b.date <=> a.date}).reverse

    #is match all tags checked?
    @match_all = params[:match_all]

    #contains outings matching at least one tag & multiple tags
    @filtered_at_least_one_tag = @filtered_by_tag.uniq
    @filtered_multiple_tags = @filtered_by_tag.select{|p| @filtered_by_tag.count(p) > 1}
    @filtered_multiple_tags.uniq!
  end

end
