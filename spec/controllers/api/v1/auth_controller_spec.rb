require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do

  describe 'POST #login' do
    let(:user) { create :user }

    context 'with valid params' do
      before { post :login, email: user.email, password: user.password }

      it 'returns a response containing an authentication token' do
        expect(json_response[:auth_token]).to be_present
      end
    end

    context 'with invalid params' do
      before { post :login, email: user.email }

      it 'returns an error message' do
        expect(json_response[:errors]).to eq ['Invalid email/password']
      end
    end
  end
end
