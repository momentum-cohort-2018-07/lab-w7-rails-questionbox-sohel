class UsersController < ApplicationController
    skip_before_action :verify_authentication, only: [:new, :create, :index]

    # How can I get error notice to let them know exactly what went wrong??
    def create
        
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "User successfully created."
        else
            redirect_to new_user_path, notice: "Something went wrong, please try again."
        end
    end
    def index
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
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