class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :latest_writings

  def index
    if current_user
      @a_writings = Writing.privy( current_user).
        offset( rand( Writing.count)).first
    else
      @a_writing = Writing.for_strangers.scoped.
        offset( rand( Writing.count)).first
    end

    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def unauthorized
    render :file => 'public/401.html', :status => :unauthorized
  end

  ### application helpers ###

  def current_user
    @current_user ||= User.find( session[:user_id]) if session[:user_id]
  end

  def latest_writings
    @latest_writings = Writing.privy( current_user).
      order( 'created_at DESC').limit( 10)
  end
end
