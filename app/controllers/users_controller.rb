class UsersController < ApplicationController
    skip_before_action :verify_authentication, only: [:new, :create, :index]

    
    def create 
        @user = User.new(user1_params)
    
            if @user.save
                UserMailer.with(user: @user).welcome_email.deliver_now
                session[:user_id] = @user.id
                redirect_to root_path, notice: "User successfully created."
            else
                redirect_to new_user_path, notice: "Something went wrong, please try again."
            end
    end

    def index
    end

    def update
        if current_user.id != @user_id
            flash[:notice] = "You cannot update this user"
        end
        @user = User.find(params[:id])
        if @user.photo.attach(user_params[:photo])
          flash[:notice] = "Profile updated"
          redirect_to @user
  
        else
          flash[:notice] = "Not uploaded"
          redirect_to @user
          
        end
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
            params.require(:user).permit(:username, :password, :photo, :email)
        end
        def user1_params
            params.permit(:username, :password, :photo, :email)
        end
        
end