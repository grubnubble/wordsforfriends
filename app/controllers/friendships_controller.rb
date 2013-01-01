class FriendshipsController < ApplicationController

  def approve
    @friendship = current_user.inverse_friendships.where( :user_id => params[:id])
    @friendship.update_all( :approved => true)
    redirect_to control_path
  end

  def create
    @friendship = current_user.friendships.build( :friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to control_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to control_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to control_path
  end
end
