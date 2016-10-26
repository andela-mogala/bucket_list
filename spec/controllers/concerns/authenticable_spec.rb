require 'rails_helper'

class Auth
  include Authenticable
end

RSpec.describe 'Authenticable' do
  let(:authentication) { Auth.new }
  let(:user) { create :user }
  before do
    allow_any_instance_of(Auth).to receive(:http_token).
      and_return(user.auth_token)
  end

  describe '#http_token' do
    it 'returns the auth token' do
      expect(authentication.http_token).to eq user.auth_token
    end
  end

  describe '#auth_token' do
    it 'returns a hash containing user_id, issued_at and expires_at' do
      expect(authentication.auth_token[:user_id]).to be_present
      expect(authentication.auth_token[:issued_at]).to be_present
      expect(authentication.auth_token[:expires_at]).to be_present
    end
  end

  describe '#authenticate_user!' do
    context 'when auth_token is valid' do
      it 'sets the current_user' do
        authentication.authenticate_user!
        expect(authentication.current_user).to eq user
      end
    end
  end
end
