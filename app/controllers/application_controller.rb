class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  attr_reader :current_user

  def authenticate_user!
    return render json: { errors: ['Not Authorized'] },
      status: :unauthorized unless user_id_in_token?
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authorized'] }, status: :unauthorized
  end

  private

  def http_token
    @http_token ||= request.headers['Authorization'].split.last if
      request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
