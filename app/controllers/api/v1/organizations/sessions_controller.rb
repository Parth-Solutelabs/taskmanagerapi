class Api::V1::Organizations::SessionsController < Devise::SessionsController

  before_action :configure_sign_in_params, only: [:create]
  skip_before_action :process_token

  def create
    organization = Organization.find_by_email(sign_in_params[:email])
    if organization && organization.valid_password?(sign_in_params[:password])
      token = organization.generate_jwt
      render json: { Token: token }
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }
    end
  end

  protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
end
