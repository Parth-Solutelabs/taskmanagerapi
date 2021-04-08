class Api::V1::Users::RegistrationsController < Devise::RegistrationsController

  skip_before_action :process_token, only: [:create]
  skip_before_action :authenticate_scope!
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    user = User.new(sign_up_params)
    if user.save
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def update
    user = User.find_by_id(params[:id])
    if user.update(account_update_params)
      render json: { data: user, message: I18n.t('users.registrations.update.success') }, status: 200
    else
      render json: { error: user.errors.full_messages }, status: 400
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if user.destroy
      render json: { message: I18n.t('users.registrations.destroy.success') }, status: 200
    else
      render json: { error: I18n.t('users.registrations.destroy.danger') }, status: 400
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :contact, :organization_id, :activate ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :contact, :organization_id, :activate ])
  end

end