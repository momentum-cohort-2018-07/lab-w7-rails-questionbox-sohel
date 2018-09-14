class Api::V1::BaseController < ApplicationController
    # disable csrf token
    protect_from_forgery with: :null_session
    # disable cookies
    before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

end