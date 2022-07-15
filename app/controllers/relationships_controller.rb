class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    render json: { message: 'followed' }, status: :ok
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    render json: { message: 'unfollowed' }, status: :ok
  end
end
