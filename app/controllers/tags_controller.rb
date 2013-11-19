class TagsController < ApplicationController


#GET '/tags'
  def view
    #view all tags
    @tags = Tag.all
  end

#GET '/tags/new'
  def new
    #form for new tag, get request
    @tag = Tag.new
    #this is for when i was trying to get the meetup API to work. it currently is broken:
    # url = "https://api.meetup.com/2/open_events.xml?zip=10012&topic=#{@tag.name}&time=,1w&key=244a69782b412853406c706c4d2f5c57"
    # response = httparty.get(url)
      # meetup_info = response["results"]["items"]["item"]
      # meetup_info.each do |i|
      #   "address" = i["venue"]["address_1"] + " " + i["venue"]["city"] + ", " + i["venue"]["state"]
      #   "description" = i["description"]
      #   "sponsor" = i["group"]["name"]
      #   "name" = i["name"]
      #   "link" = i["event_url"]
      #   "time" = i["time"]
      #   outing = Outing.find_by_name("name")
      #   unless outing
      #     outing = Outing.create({:name => "name",:date => "time", :address => "address", :description => "description", :sponsor => "sponsor", :link => "link"})
      #     outing.tags << @tag
      #   end
      # end
  end

#POST '/tags'
  def create
    #retrieves form params and saves new tag
    @tag = params[:tag]
    tag = Tag.create(@tag)
    #redirects to '/tags/@tag_id'
    if tag.save
      redirect_to "/tags/#{tag.id}"
    else
    end
  end

#GET '/tags/:id'
  def show
    id = params[:id]
    @tag = Tag.find(id)
  end


#GET '/tags/:id/delete'
  def destroy
    id = params[:id]
    @tag = Tag.find(id)
    @tag.destroy
    redirect_to "/tags"
  end

end
