require 'rails_helper'

RSpec.describe 'Invalid routes', type: :request do
  let(:user) { create :user }
  let(:header) { { authorization: user.auth_token } }

  describe 'GET /some_route' do
    context 'when route doesn\'t exist' do
      before { get '/people', {}, header }

      it 'returns an error json' do
        expect(json_response[:error]).to be_present
      end

      it 'returns status indicating resource is not found' do
        expect(response.status).to eq 404
      end
    end
  end
end
