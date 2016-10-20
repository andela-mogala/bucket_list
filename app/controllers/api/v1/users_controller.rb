class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    user = User.find_by(id: params[:id])
    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    return render json: { errors: user.errors }, status: 422 unless
      user.save
    render json: user, status: 201
  end

  def update
    user = User.find_by(id: params[:id])
    return render json: { errors: user.errors }, status: 422 unless
      user.update_attributes(user_params)
    render json: user, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
