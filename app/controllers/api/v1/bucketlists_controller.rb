module Api
  module V1
    class BucketlistsController < ApplicationController
      respond_to :json
      before_action :authenticate_user!
      before_action :find_bucketlist, only: [:show, :update, :destroy]

      def create
        bucketlist = current_user.bucketlists.build(bucketlist_params)
        return render json: { errors: bucketlist.errors }, status: 422 unless
          bucketlist.save
        render json: bucketlist, status: 201
      end

      def index
        render json: { bucketlists: current_user.bucketlists }, status: 200
      end

      def show
        render json: @bucketlist, status: 200
      end

      def update
        return render json: { errors: @bucketlist.errors }, status: 422 unless
          @bucketlist.update_attributes(bucketlist_params)
        render json: @bucketlist, status: 200
      end

      def destroy
        @bucketlist.destroy
        head 204
      end

      private

      def bucketlist_params
        params.require(:bucketlist).permit(:name, :id)
      end

      def find_bucketlist
        @bucketlist = current_user.bucketlists.find_by(id: params[:id])
      end
    end
  end
end
