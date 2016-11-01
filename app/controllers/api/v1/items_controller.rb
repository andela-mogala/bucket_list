module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate_user
      before_action :find_bucketlist, only: [:create, :index]
      before_action :find_item, only: [:show, :update, :destroy]
      respond_to :json

      def create
        item = @bucketlist.items.build(item_params)
        if item.save
          render json: item, status: 201
        else
          render json: { errors: item.errors }, status: 422
        end
      end

      def index
        render json: { items: @bucketlist.items }, status: 200
      end

      def show
        render json: @item, status: 200
      end

      def update
        if @item.update_attributes(item_params)
          render json: @item, status: 200
        else
          return render json: { errors: @item.errors }, status: 422
        end
      end

      def destroy
        @item.destroy
        render json: { message: resource_destroyed }, status: 204
      end

      private

      def item_params
        params.permit(:name)
      end

      def find_item
        @item = find_bucketlist.items.find_by(id: params[:id])
      end

      def find_bucketlist
        @bucketlist = current_user
                        .bucketlists
                        .find_by(id: params[:bucketlist_id])
      end
    end
  end
end
