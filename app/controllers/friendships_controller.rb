class FriendshipsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @requests = @user.friendships_to_approve
  end
  
  def create
    friendship = Friendship.create(params[:friendship])
    redirect_to "/"
  end
  
  def update
    friendship = Friendship.find(params[:id])
    friendship.approve
    redirect_to "/"
  end
  
  def destroy
    friendship = Friendship.find(params[:id])
    friendship.delete
    redirect_to "/"
  end
end