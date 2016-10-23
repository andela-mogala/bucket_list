class Api::V1::AuthController < ApplicationController
  respond_to :json

  def login
    user = User.find_by(email: params[:email])
    return render json: { errors: ['Invalid email/password'] } unless
      user.authenticate(params[:password])
    render json: payload(user)
  end

  def logout
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: { id: user.id, email: user.email }
    }
  end
end
