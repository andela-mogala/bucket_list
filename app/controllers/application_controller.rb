class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include Authenticable
  include MessageHelper

  def invalid_route
    render json: { error: unavailable_endpoint }, status: 404
  end
end
