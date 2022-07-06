class SessionsController < Devise::SessionsController

  skip_before_action :authenticate_user!

  def create

    user = User.find_by_email(sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def destroy
    User.current_user.destroy
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end