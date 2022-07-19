class RegistrationsController < Devise::RegistrationsController

  skip_before_action :authenticate_user!

  def create
    user = User.new(sign_up_params)
    user.profile_picture.attach(params[:user][:profile_picture])

    if user&.save
      token = user.generate_jwt
      render json: token.to_json, status: :created
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :first_name, :last_name, :profile_picture)
  end
end
