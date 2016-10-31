require 'rails_helper'

RSpec.describe 'Bucketlist requests', type: :request do
  let!(:user) { create :user }
  let(:header) { { authorization: user.auth_token } }

  describe 'POST /bucketlists' do
    let(:bucketlist) { build :bucketlist, user: user }
    let!(:initial_bucketlist_count) { Bucketlist.count }

    context 'with valid params' do
      before do
        post '/bucketlists', { user_id: user.id,
                               name:  bucketlist.name }, header
      end

      it 'persists bucketlist to database' do
        expect(Bucketlist.count).to eq initial_bucketlist_count + 1
      end

      it 'returns a json response containing the recently created object' do
        expect(json_response[:name]).to eq bucketlist.name
      end

      it 'has a response status indicating success' do
        expect(response.status).to eq 201
      end
    end

    context 'with invalid params' do
      before do
        post '/bucketlists', { user_id: user.id,
                               name: nil }, header
      end

      it 'does not persist to the databse' do
        expect(Bucketlist.count).to eq initial_bucketlist_count
      end

      it 'returns an error json' do
        expect(json_response[:errors]).to be_present
      end

      it 'has a response status indicating failure' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /bucketlists' do
    let!(:bucketlists) { create_list :bucketlist, 20, user: user }
    before { get '/bucketlists', {}, header }

    it 'returns all bucketlists' do
      expect(json_response[:bucketlists].size).to eq bucketlists.size
    end

    it 'return a success status code' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET /bucketlists/:id' do
    let(:bucketlist) { create :bucketlist, user: user }
    before { get "/bucketlists/#{bucketlist.id}", {}, header }

    it 'returns a bucketlist' do
      expect(json_response[:name]).to eq bucketlist.name
    end

    it 'returns a success status code' do
      expect(response.status).to eq 200
    end
  end

  describe 'PUT/PATCH /bucketlists/:id' do
    let(:user) { create :user }
    let(:bucketlist) { create :bucketlist, user: user }

    context 'with valid params' do
      before do
        patch "/bucketlists/#{bucketlist.id}",
              { name: 'Something Nice' }, header
      end

      it 'updates the bucketlist' do
        expect(bucketlist.reload.name).to eq 'Something Nice'
      end

      it 'returns json response of updated bucketlist' do
        expect(json_response[:name]).to eq 'Something Nice'
      end

      it 'has a success response status' do
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params' do
      before do
        patch "/bucketlists/#{bucketlist.id}", { name: nil }, header
      end

      it 'does not update' do
        expect(bucketlist.reload.name).to_not be_nil
        expect(bucketlist.reload.name).to eq bucketlist.name
      end

      it 'returns a json error response' do
        expect(json_response[:errors]).to be_present
      end

      it 'has response status indicating failure' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE /bucketlists/:id' do
    let!(:user) { create :user }
    let!(:bucketlist) { create :bucketlist, user: user }

    before { delete "/bucketlists/#{bucketlist.id}", {}, header }

    it 'removes the bucketlist from the database' do
      expect(Bucketlist.find_by(id: bucketlist.id)).to be_nil
    end

    it 'returns a response status indicating success' do
      expect(response.status).to eq 204
    end
  end
end
