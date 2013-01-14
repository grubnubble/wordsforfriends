class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def index
    @awriting = Writing.offset( rand( Writing.count)).first
    @latestwritings = Writing.order( 'created_at DESC').limit( 10)
    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def control
    if current_user

      @user = current_user

      @outgoingfriendrequests = Friendship.where( :user_id => @user.id, :approved => false)
      @incomingfriendrequests = Friendship.where( :friend_id => @user.id, :approved => false)
      @realfriends = Friendship.where( "(user_id = ? OR friend_id = ?) AND approved = ?",
        @user.id, @user.id, true)

      @writings = Writing.where( :author_id => @user.id)

      respond_to do |format|
        format.html #control.html.erb
      end
    else
      self.block
    end
  end

  def block
    render :file => 'public/401.html', :status => :unathorized
  end

  def current_user
    @current_user ||= User.find( session[:user_id]) if session[:user_id]
  end
end
