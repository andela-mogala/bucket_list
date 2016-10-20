class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    user = User.find_by(id: params[:id])
    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    return render json: { errors: user.errors }, status: 401 unless user.save
    render json: user, status: 201
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
