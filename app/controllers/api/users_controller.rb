class Api::V1::UsersController < ApplicationController 
    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find_by_id(params[:id])
        if @user
            render json: @user, status: 200
        else
            render { error: I18n.t('users.show.danger') }, status: 400
        end
    end

    def tasks
        @tasks = @user.tasks
        render json: @tasks
    end

    def projects
        @projects = user.projects
        render json: @projects
    end

    private

    def user_params
        params.require(:user).permit(:name, :organization_id, :contact)
    end
end