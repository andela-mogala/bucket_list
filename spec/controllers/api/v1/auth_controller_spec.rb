require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  let!(:user) { create :user }

  describe 'POST #login' do

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

  describe 'GET #logout' do
    context 'when signed in' do
      before do
        sign_in user
        get :logout
      end

      it 'has a message indicating logout success' do
        expect(json_response[:message]).to eq 'You have been logged out'
      end
    end
  end
end
