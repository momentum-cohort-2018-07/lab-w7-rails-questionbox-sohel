class Api::V1::BaseController < ApplicationController 
  
    # disable cookies
    before_action :destroy_session, :verify_authentication
    helper_method :current_user

  def destroy_session
    request.session_options[:skip] = true
  end

  def verify_authentication
    unless current_user
      render json: {error: "You don't have permission to access these resources"}, status: :unauthorized
    end
  end

  protected

  def current_user
    @current_user ||= authenticate_with_http_token do |token, options|
      User.find_by_api_token(token)
    end
  end

end