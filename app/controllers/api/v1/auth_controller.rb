class Api::V1::AuthController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, only: [:logout]
  before_action :find_user

  def login
    return render json: { errors: ['Invalid email/password'] } unless
      @user.authenticate(params[:password])
    generate_token_and_save
    render json: { auth_token: @user.auth_token }
  end

  def logout
    current_user.generate_token!
    current_user.update_attribute(:auth_token, current_user.auth_token)
    render json: { message: 'You have been logged out' }
  end

  private

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def generate_token_and_save
    @user.generate_token!
    @user.update_attribute(:auth_token, @user.auth_token)
  end
end
