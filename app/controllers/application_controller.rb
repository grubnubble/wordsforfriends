class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :latest_writings

  def index
    writings = []
    if current_user
#      writings = 
#        Writing.by_friends(current_user.friends).for_friends + 
#        Writing.by_strangers(current_user.friends).for_strangers
      writings = Writing.privy( current_user)
    else
      writings = Writing.for_strangers
    end
    @a_writing = writings.sample 

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
    @latest_writings = Writing.for_strangers.order( 'created_at DESC').limit( 10)
  end
end
