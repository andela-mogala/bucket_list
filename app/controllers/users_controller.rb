
class UsersController < ApplicationController
  before_action :find_user, except: [:create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    return render 'new' unless user.save
    redirect_to action: 'show'
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end

