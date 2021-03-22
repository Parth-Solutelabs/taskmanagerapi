class UserMailer < ApplicationMailer
    def invite_user(user)
        @user = user
        mail to: user.email, subject: "You have received an invitation to join project from #{user.name}"
    end
end
