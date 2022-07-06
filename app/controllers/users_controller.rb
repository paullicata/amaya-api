class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  skip_before_action  :authenticate_user!

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if !user_params.empty? && @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :first_name, :last_name)
  end

end
