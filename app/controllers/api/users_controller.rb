class Api::V1::UsersController < ApplicationController 
    def index
        @users = User.all
        render json: @users
    end

    def show
        @users = User.find_by(params[:id])
        render json: @users
    end


    def update
        @users = User.find_by(params[:id])
        if @users
            @users.update(user_params)
            render json: { message: 'user updated.'}, status: 200
        else
            render error: { error: 'unable to update user' }, status: 400
        end
    end

    def destroy
        @users = User.find_by(params[:id])
        if @users
            @user.destroy
            render json: {message: 'User deleted'}, status: 200
        else
            render error: { error: 'unable to delete'}, status: 400
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :email, :organization_id, :contact)
    end
end