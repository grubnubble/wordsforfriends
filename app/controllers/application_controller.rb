class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :latest_writings

  def index
    @a_writing = current_user ? 
      ( Writing.privy( current_user)).sample :
      ( Writing.for_strangers).sample

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
