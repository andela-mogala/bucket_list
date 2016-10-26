module Api
  module V1
    class Api::V1::ItemsController < ApplicationController
      before_action :authenticate_user!
      before_action :find_bucketlist, only: [:create, :index]
      before_action :find_item, only: [:show, :update, :destroy]
      respond_to :json

      def create
        item = @bucketlist.items.build(item_params)
        return render json: { errors: item.errors}, status: 422 unless
          item.save
        render json: item, status: 201
      end

      def index
        render json: { items: @bucketlist.items }, status: 200
      end

      def show
        render json: @item, status: 200
      end

      def update
        return render json: { errors: @item.errors }, status: 422 unless
          @item.update_attributes(item_params)
        render json: @item, status: 200
      end

      def destroy
        @item.destroy
        head 204
      end

      private

      def item_params
        params.permit(:name)
      end

      def find_item
        @item = find_bucketlist.items.find_by(id: params[:id])
      end

      def find_bucketlist
        @bucketlist = current_user.bucketlists.
          find_by(id: params[:bucketlist_id])
      end
    end
  end
end
