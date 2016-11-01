module Api
  module V1
    class BucketlistsController < ApplicationController
      respond_to :json
      before_action :authenticate_user
      before_action :find_bucketlist, only: [:show, :update, :destroy]

      def create
        bucketlist = current_user.bucketlists.build(bucketlist_params)
        if bucketlist.save
          render json: bucketlist, status: 201
        else
          render json: { errors: bucketlist.errors }, status: 422
        end
      end

      def index
        render json: { bucketlists: current_user.bucketlists.search(params) },
               status: 200
      end

      def show
        render json: @bucketlist, status: 200
      end

      def update
        if @bucketlist.update_attributes(bucketlist_params)
          render json: @bucketlist, status: 200
        else
          render json: { errors: @bucketlist.errors }, status: 422
        end
      end

      def destroy
        @bucketlist.destroy
        render json: { message: resource_destroyed }, status: 204
      end

      private

      def bucketlist_params
        params.permit(:name)
      end

      def find_bucketlist
        @bucketlist = current_user.bucketlists.find_by(id: params[:id])
      end
    end
  end
end
