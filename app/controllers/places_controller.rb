class PlacesController < ApplicationController

#GET '/';
  def view
    #view all places
    @places = Place.all
  end

#GET '/places/new'
  def new
    #form for new place, get request
    @place = Place.new
  end

#POST '/places'
  def create
    #retrieves form params and saves new place
    @place = params[:place]
    @tags = @place[:tags]
    place = Place.new
    place.name = @place[:name]
    place.date = @place[:date]
    place.start_time = @place[:start_time]
    place.sponsor = @place[:sponsor]
    place.location = @place[:location]
    place.venue_address = @place[:venue_address]
    place.description = @place[:description]
    place.link = @place[:link]
    place.end_time = @place[:end_time]
    place.end_date = @place[:end_date]
    #redirects to '/places/@place_id'
    if place.save
      if @tags != nil
        place.tag!(@tags)
      end
      redirect_to "/places/#{place.id}"
    else
      redirect_to "/places" #add flash
    end
  end

#GET '/places/:id'
  def show
    id = params[:id]
    @place = Place.find(id)
  end

#GET '/place/:id/edit'
  def edit
    id = params[:id]
    @place = Place.find(id)
  end

#POST '/places/:id'
  def update
    #retrieves form params and updates place
    id = params[:id]
    @place = params[:place]
    @tags = @place[:tags]
    place = Place.find(id)
    place.name = @place[:name]
    place.date = @place[:date]
    place.start_time = @place[:start_time]
    place.sponsor = @place[:sponsor]
    place.location = @place[:location]
    place.venue_address = @place[:venue_address]
    place.description = @place[:description]
    place.link = @place[:link]
    place.end_time = @place[:end_time]
    place.end_date = @place[:end_date]
    place.save
    if place.save
      if @tags != nil
        place.tag!(@tags)
      end
      redirect_to("/places")
    end
  end

#GET '/places/:id/delete'
  def destroy
    id = params[:id]
    @place = Place.find(id)
    @place.destroy
    redirect_to "/places"
  end

end
