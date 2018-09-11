class Api::SessionsController < ApplicationController
  skip_before_action :verify_authentication
  
  

  def create
    user = User.find(params["user_id"])
  

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to api_root_path
    else
      flash[:error_message] = "Invalid username and/or password."
      redirect_to api_session_path
    end
  end

  def destroy
  end

  private
  def user_params
      params.permit(:username, :password)
  end
end
