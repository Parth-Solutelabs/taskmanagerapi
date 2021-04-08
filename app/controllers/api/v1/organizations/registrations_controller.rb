class Api::V1::Organizations::RegistrationsController < Devise::RegistrationsController

  skip_before_action :process_token, only: [:create]
  skip_before_action :authenticate_scope!
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :check_for_correct_organization, only: [:update, :destroy]

  def create
    organization = Organization.new(sign_up_params)
    if organization.save
      token = organization.generate_jwt
      render json: token.to_json
    else
      render json: { errors: organization.errors.full_messages }
    end
  end

  def update
    organization = Organization.find_by_id(params[:id])
    if organization.update(account_update_params)
      render json: { data: organization, message: I18n.t('organizations.registrations.update.success') }, status: 200
    else
      render json: { error: organization.errors.full_messages }, status: 400
    end
  end

  def destroy
    organization = Organization.find_by_id(params[:id])
    if organization.destroy
      render json: { message: I18n.t('organizations.registrations.destroy.success') }, status: 200
    else
      render json: { error: I18n.t('organizations.registrations.destroy.danger') }, status: 400
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :contact ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :contact])
  end

end