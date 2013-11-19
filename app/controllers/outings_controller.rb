class OutingsController < ApplicationController
before_filter :authorize, only: [:edit, :update, :new, :create, :destroy]

#GET '/';
  def view
    #view all outings
    @outings = Outing.all
  end

#GET '/outings/new'
  def new
    #form for new outing, get request
    @outing = Outing.new
  end

#POST '/outings'
  def create
    #retrieves form params and saves new outing
    @outing = params[:outing] #TODO remove instance variable
    @tags = @outing[:tags]

    #notes from jonathan:
    # filtered_params = params[:outing].except(:tags) #http://stackoverflow.com/questions/711863/ruby-hash-filter
    # outing = Outing.new(filtered_params)

    outing = Outing.new()
    outing.name = @outing[:name]
    if @outing[:date] != nil && @outing[:date] != "" && Date.parse(@outing[:date])
       outing.date = Date.strptime(@outing[:date], "%m/%d/%Y")
    else
      outing.date = ""
    end
    if @outing[:end_date] != nil && @outing[:end_date] != ""
      outing.end_date = Date.strptime(@outing[:end_date], "%m/%d/%Y")
    else
      outing.end_date = ""
      #these if/else statements fix a bug i was having where
      #if you didn't enter a date,
      #or you endered an invalid date with random letters 'dafda'
      #the create outing/events submission would break
    end
    outing.start_time = @outing[:start_time]
    outing.sponsor = @outing[:sponsor]
    outing.location = @outing[:location]
    outing.venue_address = @outing[:venue_address]
    outing.description = @outing[:description]
    outing.link = @outing[:link]
    outing.end_time = @outing[:end_time]
    #saves each property individually, since I had to do something
    # different with the dates and with the tags
    #this is why i didnt just use outing.create(:name => @outing[:name], ..etc)
    if outing.save
      if @tags != nil
        outing.tag!(@tags) #see my outing model for what this is doing
      end
      redirect_to "/outings/#{outing.id}"
    else
    #it doesnt save unless the start date is blank or a number,
    #if it doesnt save, the user sees this flash alert
    flash[:alert] = "Something went wrong! Did you enter the date correctly?"
    redirect_to :back
    end
  end

#GET '/outings/:id'
  def show
    id = params[:id]
    @outing = Outing.find(id)
  end

#GET '/outing/:id/edit'
  def edit
    id = params[:id]
    @outing = Outing.find(id)
  end

#POST '/outings/:id'
  def update
    #retrieves form params and updates outing
    id = params[:id]
    @outing = params[:outing]
    @tags = @outing[:tags]
    outing = Outing.find(id)
    #saves each property individually, since I had to do something
    # different with the tags
    #this is why i didnt just use outing.create(:name => @outing[:name], ..etc)
    outing.name = @outing[:name]
    outing.date = @outing[:date]
    outing.start_time = @outing[:start_time]
    outing.sponsor = @outing[:sponsor]
    outing.location = @outing[:location]
    outing.venue_address = @outing[:venue_address]
    outing.description = @outing[:description]
    outing.link = @outing[:link]
    outing.end_time = @outing[:end_time]
    outing.end_date = @outing[:end_date]
    outing.save
    if outing.save
      if @tags != nil #see my outing model for what this is doing
        outing.tag!(@tags)
      end
      redirect_to("/outings")
    end
  end

#GET '/outings/:id/delete'
  def destroy
    id = params[:id]
    @outing = Outing.find(id)
    @outing.destroy
    redirect_to "/"
  end
# note from jonathan:
# scope :current_outings, where("date > ?", 1.day.ago)
end
