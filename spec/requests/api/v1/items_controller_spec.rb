require 'rails_helper'

RSpec.describe 'Items Endpoints', type: :request do
  let(:user) { create :user }
  let(:bucketlist) { create :bucketlist, user: user }
  let(:header) { { authorization: user.auth_token } }

  describe 'POST /bucketlists/:id/items' do
    let(:item) { build :item, bucketlist: bucketlist }
    let!(:initial_item_count) { Item.count }

    context 'with valid params' do
      before do
        post "/bucketlists/#{bucketlist.id}/items", { name: item.name },
             header
      end

      it 'creates an item' do
        expect(Item.count).to eq initial_item_count + 1
      end

      it 'has json response containing new item' do
        expect(json_response[:name]).to eq item.name
      end

      it 'has  success response status' do
        expect(response.status).to eq 201
      end
    end

    context 'with invalid params' do
      before do
        post "/bucketlists/#{bucketlist.id}/items", { name: nil },
             header
      end
      it 'does not create an item' do
        expect(Item.count).to eq initial_item_count
      end

      it 'has json response containing errors' do
        expect(json_response[:errors]).to be_present
      end

      it 'has failure response status' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /bucketlists/:id/items' do
    let(:items) { create_list :item, 20, bucketlist: bucketlist }

    before { get "/bucketlists/#{bucketlist.id}/items", {}, header }

    it 'returns all items in a bucket list' do
      expect(json_response[:items].size).to eq bucketlist.items.size
    end

    it 'has a success response status' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET /bucketlists/:id/items/:item_id' do
    let(:item) { create :item, bucketlist: bucketlist }

    before do
      get "/bucketlists/#{bucketlist.id}/items/#{item.id}", {}, header
    end

    it 'returns a single item in the bucket list' do
      expect(json_response[:name]).to eq item.name
    end

    it 'has a success response status' do
      expect(response.status).to eq 200
    end
  end

  describe 'PUT/PATCH /bucketlists/:id/items/:item_id' do
    let(:item) { create :item, bucketlist: bucketlist }

    context 'with valid parameters' do
      before do
        patch "/bucketlists/#{bucketlist.id}/items/#{item.id}",
              { name: 'Build an api service' }, header
      end

      it 'successfully updates the item' do
        expect(item.reload.name).to eq 'Build an api service'
      end

      it 'returns a json response of the updated item' do
        expect(json_response[:name]).to eq 'Build an api service'
      end

      it 'has a response status indicating success' do
        expect(response.status).to eq 200
      end
    end

    context 'with invalid parameters' do
      before do
        patch "/bucketlists/#{bucketlist.id}/items/#{item.id}",
              { name: nil }, header
      end

      it 'fails to update the item' do
        expect(item.reload.name).to eq item.name
      end

      it 'returns a json response of the errors encoutered' do
        expect(json_response[:errors]).to be_present
      end

      it 'has a response status indicating failure' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE /bucketlists/:id/items/:item_id' do
    let(:item) { create :item, bucketlist: bucketlist }
    before do
      delete "/bucketlists/#{bucketlist.id}/items/#{item.id}", {}, header
    end

    it 'deletes the item from the bucketlist' do
      expect(bucketlist.reload.items).to_not include item
    end

    it 'returns a response status indicating success' do
      expect(response.status).to eq 204
    end
  end
end
