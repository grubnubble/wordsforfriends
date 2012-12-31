class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def index
    @apoem = Writing.offset( rand( Writing.count)).first
    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def current_user
    @current_user ||= User.find( session[:user_id]) if session[:user_id]
  end
end
