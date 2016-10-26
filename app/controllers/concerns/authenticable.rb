module Authenticable
  attr_accessor :current_user

  def authenticate_user!
    @current_user = User.find(auth_token[:user_id])
    return render json: { errors: ['Not Authorized/Session Expired. Please Login'] } unless
      @current_user.token_expired?(http_token)
    rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authorized'] }, status: :unauthorized
  end

  def http_token
    http_token ||= request.headers['Authorization'].split.last if
      request.headers['Authorization'].present?
  end

  def auth_token
    auth_token ||= JsonWebToken.decode(http_token)
  end
end