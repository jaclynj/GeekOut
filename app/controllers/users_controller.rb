class UsersController < ApplicationController
def new
  @user = User.new
end

def create
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    flash[:notice] = "Thank you for signing up!"
    redirect_to root_url
  else
    if @user.errors.any?
      @user.errors.messages.each do |error, msg|
        flash.now.alert = error.to_s.gsub("_confirmation", " ").capitalize + " " + msg.to_s.delete("[]\"\"")
      end
    end
    render "new"
  end
end

end
