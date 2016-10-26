class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include Authenticable

  def invalid_route
    render json: {
      error: "the end point #{params[:url]} is not available"
    }, status: 400
  end
end
