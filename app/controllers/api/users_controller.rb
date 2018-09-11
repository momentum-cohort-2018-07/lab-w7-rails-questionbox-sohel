class Api::UsersController < ApplicationController
    skip_before_action :verify_authentication, only: [:create, :index]

    # How can I get error notice to let them know exactly what went wrong??
    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to api_root_path, notice: "User successfully created."
        else
            redirect_to api_users_path, notice: "Something went wrong, please try again."
        end
    end
    def index
    end


    def show
        @user = User.find(params[:user_id])
        @posts = @user.posts
    end

    def destroy
        if current_user == @user
            @user.destroy
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.permit(:username, :password)
        end
end