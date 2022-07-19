class RelationshipsController < ApplicationController

  skip_before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    render json: { message: 'followed' }, status: :ok
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    render json: { message: 'unfollowed' }, status: :ok
  end
end
