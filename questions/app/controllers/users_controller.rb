class UsersController < ApplicationController
    skip_before_action :verify_authentication, only: [:new, :create, :index, :show]

    
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

    def edit
        set_user
    end

    def update
        set_user
        if current_user.id != @user_id
            flash[:notice] = "You cannot update this user"
        end
        if @user.update_attributes(user_params)
            flash[:notice] = "Profile updated"
            redirect_to @user
        else
            flash[:notice] = "Unsuccesful"
            redirect_to @user
        end
       
    end

    def new
        @user = User.new
    end

    def show
        set_user
        @posts = @user.posts
    end

    def destroy
        set_user
        if current_user == @user
            @user.destroy
            redirect_to root_path
        else
            flash[:notice] = "Could not delete"
            redirect_to @user
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :password, :photo, :email)
        end
        def user1_params
            params.permit(:username, :password, :photo, :email)
        end
        def set_user
            @user = User.find(params[:id])
        end
        
end