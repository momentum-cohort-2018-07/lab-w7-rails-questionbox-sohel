class Api::V1::SessionsController < Api::V1::BaseController

    skip_before_action :verify_authentication
  

  def create
    user = User.find_by_username(params[:username])
    if  user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { token: user.api_token }
    else
        render json: { error: "Invalid" }, status: :unauthorized
    end
  end

end