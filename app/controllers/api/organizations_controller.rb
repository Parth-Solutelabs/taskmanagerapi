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

    def users
        @users = current_organization.users.where("activate=true")
        render json: @users
        @unactive = current_organization.users.where("activate=false")
        render json: @unactive
    end

    def tasks
        if params[:from] = 'project'
            @tasks = project
            render json: @tasks
        end
    end

    def projects
        @projects = current_organization.projects
        render json: @projects
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
        params.require(:organization).permit(:name, :contact)
    end
end