class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_p

  def current_p
    @places = Place.where("date > ?", Date.today)
    @places
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  helper_method :current_user #turns this into a helper method so it can be used in views

  def authorize
    redirect_to login_url, alert: "You must log in to add or edit events" if current_user.nil?
  end

end
