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
