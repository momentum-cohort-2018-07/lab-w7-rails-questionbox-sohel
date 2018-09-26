class Api::V1::UsersController < Api::V1::BaseController
    

    skip_before_action :verify_authentication, only: [:index, :new, :create, :show]
    protect_from_forgery with: :null_session
    def index
        @users = User.all
        render json: @users
    end

    def create
        
        @user = User.new(user_params)

        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end
    
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        render json: @posts
    end

    def destroy
        if  @user.destroy
            render json: @user, status: :accepted
        else
            render json: @user.errors, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:username, :password)
    end
end