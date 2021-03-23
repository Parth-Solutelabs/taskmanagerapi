class ApplicationController < ActionController::API
    respond_to :json
    before_action :process_token    
    private
        def process_token
            if request.headers['Authorization'].present?
                begin
                    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[0], Rails.application.secrets.secret_key_base).first
                    @current_organization_id = jwt_payload['id']
                rescue Exception => e 
                    render json: { error: e.message }
                end
            else
                render json:{ error: 'Token is Empty' } 
            end
        end
        

        def authenticate_organization!(opthions = {})
            head :unauthorized unless signed_in?
        end

        def current_organization
            @current_organization ||= super || Organization.find(@current_organization_id)
        end

        def signed_in?
            @current_organization_id.present?
        end

        def authenticate_user!(opthions = {})
            head :unauthorized unless signed_in?
        end

        def current_user
            @current_user ||= super || User.find(@current_user_id)
        end

        def signed_in?
            @current_user_id.present?
        end

end
