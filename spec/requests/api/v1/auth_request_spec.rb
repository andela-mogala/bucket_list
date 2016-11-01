require 'rails_helper'

RSpec.describe 'Authentication requests', type: :request do
  let!(:user) { create :user }
  let!(:header) { { authorization: user.auth_token } }

  describe 'POST /auth/login' do
    context 'with valid params' do
      before do
        post auth_login_path, email: user.email, password: user.password
      end

      it 'returns a response containing an authentication token' do
        expect(json_response[:auth_token]).to be_present
      end
    end

    context 'with incomplete params' do
      before { post auth_login_path, email: user.email }

      it 'returns an error message' do
        expect(json_response[:errors]).to eq ['Invalid email/password']
      end
    end
  end

  describe 'GET /auth/logout' do
    context 'when signed in' do
      before do
        get auth_logout_path, {}, header
      end

      it 'has a message indicating logout success' do
        expect(json_response[:message]).to eq 'You have been logged out'
      end
    end

    context 'with invalid auth_token' do
      before do
        header['Authorization'] = 'sadhjbdasbjhabsjhba'
        get auth_logout_path, {}, header
      end

      it 'returns \'Not Authorized\'' do
        expect(json_response[:errors]).to eq ['Not Authorized']
      end
    end
  end
end
