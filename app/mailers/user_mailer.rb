class UserMailer < ApplicationMailer
    default from: 'Questionbox@qb.com'

    def welcome_email
        @user = params[:user]
        @url  = 'http://localhost3000'
        mail(to: @user.email, subject: 'Welcome to QuestionBox!')
    end

    def send_weekly_email
        @user = params{:user}
        @user = 'http://localhost:3000'
        mail(to: @user.email, subject: 'Your Recent Activity')
end
