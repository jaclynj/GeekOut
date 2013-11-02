class PlacesController < ApplicationController
before_filter :authorize, only: [:edit, :update, :new, :create, :destroy]

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
    @place = params[:place] #TODO remove instance variable
    @tags = @place[:tags]

    #notes from jonathan:
    # filtered_params = params[:place].except(:tags) #http://stackoverflow.com/questions/711863/ruby-hash-filter
    # place = Place.new(filtered_params)

    place = Place.new()
    place.name = @place[:name]
    if @place[:date] != nil && @place[:date] != "" && Date.parse(@place[:date])
       place.date = Date.strptime(@place[:date], "%m/%d/%Y")
    else
      place.date = ""
    end
    if @place[:end_date] != nil && @place[:end_date] != ""
      place.end_date = Date.strptime(@place[:end_date], "%m/%d/%Y")
    else
      place.end_date = ""
      #these if/else statements fix a bug i was having where
      #if you didn't enter a date,
      #or you endered an invalid date with random letters 'dafda'
      #the create place/events submission would break
    end
    place.start_time = @place[:start_time]
    place.sponsor = @place[:sponsor]
    place.location = @place[:location]
    place.venue_address = @place[:venue_address]
    place.description = @place[:description]
    place.link = @place[:link]
    place.end_time = @place[:end_time]
    #saves each property individually, since I had to do something
    # different with the dates and with the tags
    #this is why i didnt just use place.create(:name => @place[:name], ..etc)
    if place.save
      if @tags != nil
        place.tag!(@tags) #see my place model for what this is doing
      end
      redirect_to "/places/#{place.id}"
    else
    #it doesnt save unless the start date is blank or a number,
    #if it doesnt save, the user sees this flash alert
    flash[:alert] = "Something went wrong! Did you enter the date correctly?"
    redirect_to :back
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
    #saves each property individually, since I had to do something
    # different with the tags
    #this is why i didnt just use place.create(:name => @place[:name], ..etc)
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
      if @tags != nil #see my place model for what this is doing
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
    redirect_to "/"
  end
# note from jonathan:
# scope :current_places, where("date > ?", 1.day.ago)
end
