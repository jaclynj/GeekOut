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

    #filters by location
    @city = params[:location]
    if @city == 'Any City' #select all cities
      @filtered_by_location = @places
      #what you do when user selects tags & all cities

      if tag_filter != nil #if the user selected tags
          tag_filter.each do |f| #for each tag selected in the search, find its relations
            @filtered_by_single_tag = Tagging.where({tag_id: f})
            @filtered_by_single_tag.each do |t| #for each selected tag's relations
              id = t.place_id #find the relations place_id
              @filtered_by_single_tag = @filtered_by_location.find_by_id(id)
              @filtered_by_tag << @filtered_by_single_tag #add that place to 'filteredbytag'
            end
          end

      else #if the user did not select tags
        @filtered_by_tag = @filtered_by_location
      end

    else #filter everything by location
      @filtered_by_location = @places.where({location: @city})
      if @filtered_by_location != [] #if events in that location exist
        if tag_filter != nil #and if the user selected tags
          tag_filter.each do |f| #for each tag selected in the search, find its relations
            @filtered_by_single_tag = Tagging.where({tag_id: f})
            @filtered_by_single_tag.each do |t| #for each selected tag's relations
              id = t.place_id #find the relations place_id
              @filtered_by_single_tag = @filtered_by_location.find_by_id(id)
              @filtered_by_tag << @filtered_by_single_tag #add that place to 'filteredbytag'
            end
          end
        else #user did not select tags but selected location
          @filtered_by_tag = @filtered_by_location
        end
      end
    end

    #is match all tags checked?
    @match_all = params[:match_all]

      #sorts by date
      @filtered_by_tag = (@filtered_by_tag.compact.sort {|a,b| b.date <=> a.date}).reverse


    #contains outings matching at least one tag & multiple tags
    @filtered_at_least_one_tag = @filtered_by_tag.uniq
    @filtered_multiple_tags = @filtered_by_tag.select{|p| @filtered_by_tag.count(p) > 1}
    @filtered_multiple_tags.uniq!
  end





end
