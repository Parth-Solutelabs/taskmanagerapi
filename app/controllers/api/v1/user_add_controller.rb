class UserAddController < ApplicationController
    before_action :authenticate_organization!, only: [:new, :create]
    before_action :get_user, only: [:edit]
    before_action :is_not_signed_in, only: [:update]
    before_action :get_update_user, only: [:update]
    before_action :validate_invitaion_link, only: [:edit, :update]
    def new
        @user = User.new
    end

    def create
        @user = current_organization.users.build(user_params)
        if @user.save
            flash[:success] = "Invitation sent successfully"
            @user.create_invite_token
            @user.send_invite_mail
            redirect_to root_path
        else
            flash[:danger] = "Not Successfull"
            render 'new'
        end
    end

    def edit
    end

    def update
        @user = User.find_by(email: params[:user_add][:email])
        if @user.update(invited_user_params)
            @user.make_activate
            flash[:success] = "You are ready now"
            redirect_to root_path
        else
            render 'edit'
        end
    end

    private

        def is_not_signed_in
            if organization_signed_in? || user_signed_in?
                flash[:danger] = "Please log out first from current session"
                redirect_to root_path
            end
        end

        def user_params
            params.require(:user_add).permit(:email,:password)
        end

        def invited_user_params
            params.require(:user_add).permit(:email,:name,:contact,:password,:password_confirmation)
        end

        def get_user
            @user = User.find_by(email: params[:email])
        end

        def get_update_user
            @user = User.find_by(email: params[:user_add][:email])
        end

        def validate_invitaion_link
            unless(@user && !@user.activate? && @user.authenticated?(:invite, params[:id]))
                flash[:danger] = "Link is not valid"
                redirect_to root_path
            end
        end

end
