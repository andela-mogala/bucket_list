module Api
  module V1
    class AuthController < ApplicationController
      respond_to :json
      before_action :authenticate_user!, only: [:logout]
      before_action :find_user

      def login
        return render json: { errors: ['Invalid email/password'] } unless
          @user.authenticate(params[:password])
        @user.generate_token_and_update
        render json: { auth_token: @user.auth_token }
      end

      def logout
        current_user.generate_token_and_update
        render json: { message: 'You have been logged out' }
      end

      private

      def find_user
        @user = User.find_by(email: params[:email])
      end
    end
  end
end
