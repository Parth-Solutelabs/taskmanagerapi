class Api::V1::Users::SessionsController < Devise::SessionsController

  before_action :configure_sign_in_params, only: [:create]
  skip_before_action :process_token

  def create
    user = User.find_by_email(sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      token = user.generate_jwt
      render json: { Token: token }
    else
      render json: {errors: I18n.t('users.sessions.create.danger')}
    end
  end

  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
end
