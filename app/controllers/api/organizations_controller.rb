class Api::V1::OrganizationsController < ApplicationController 
    def index
        @organizations = Organization.all
        render json: @organizations
    end

    def show
        @organizations = Organization.find_by(params[:id])
        render json: @organizations
    end

    def update
        @organizations = Organization.find_by(params[:id])
        if @organizations
            @organizations.update(user_params)
            render json: { message: 'organization updated.'}, status: 200
        else
            render error: { error: 'unable to update organization' }, status: 400
        end
    end

    def destroy
        @organizations = Organization.find_by(params[:id])
        if @organizations
            @organization.destroy
            render json: {message: 'Organization deleted'}, status: 200
        else
            render error: { error: 'unable to delete'}, status: 400
        end
    end

    private

    def user_params
        params.require(:organization).permit(:name, :password, :contact, :email)
    end
end