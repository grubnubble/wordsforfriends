class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

#  # GET /users/1
#  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @user }
#    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        # activation email
        UserMailer.activate_email( @user).deliver

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  ### custom actions & views ###

  # GET /profile
  def profile
    if current_user
      @outgoing_friend_requests = Friendship.where( 
        :user_id => current_user.id, :approved => false)
      @incoming_friend_requests = Friendship.where( 
        :friend_id => current_user.id, :approved => false)
      @real_friends = Friendship.where( "(user_id = ? OR friend_id = ?) AND approved = ?",
        current_user.id, current_user.id, true)

      respond_to do |format|
        format.html   # control.html.erb
      end
    else
      self.unauthorized
    end
  end

  # GET /users/activate?e_k=...
  # POST /users/activate
  def activate
    @user = User.where( :email_key => params[:e_k]).first
    unless params[:e_k] && @user
      self.unauthorized   # couldn't find anyone with the given email_key
    else
      if params[:password] && params[:email] && params[:e_k]
        # user is trying to authentication themselves
        user = User.authenticate( params[:email], params[:password], params[:e_k])
        if user && !user.active && @user.id == user.id
          # @user and user should be referencing the same record
          user.active = true
          if user.save
            # welcome user
            UserMailer.welcome_email( @user).deliver

            flash[:notice] = "Successfully activated your user."
            redirect_to root_path
          else
            flash[:error] = "Could not activate your user."
            redirect_to root_path
          end
        else
          # authentication failed, already active, or the user 
          # messed with the email_key
          flash[:error] = "Login failed.  Try again?"
        end
      end
    end
  end

end
