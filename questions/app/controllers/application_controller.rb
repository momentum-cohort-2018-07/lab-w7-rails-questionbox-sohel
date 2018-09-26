class ApplicationController < ActionController::Base
    
    
    helper_method :current_user
    helper_method :islogged
    before_action :verify_authentication

  
    def verify_authentication
      unless current_user
        render json: {error: "You don't have permission to access these resources"}, status: :unauthorized
      end
    end

private
    def comment_params
    params.permit(:post_id, comment: [:user_id, :reply] )
    end
   
    def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def islogged
        !!current_user
    end
    
  
end
  