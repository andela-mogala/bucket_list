module Authenticable
  attr_reader :current_user

  def authenticate_user!
    @current_user = User.find(auth_token[:user_id])
    return render json: { errors: [invalid_session] } unless
      @current_user.token_expired?(http_token)
    rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: [anauthorized_access] }, status: :unauthorized
  end

  def http_token
    request.headers['Authorization'].split.last if
      request.headers['Authorization'].present?
  end

  def auth_token
    JsonWebToken.decode(http_token)
  end
end
