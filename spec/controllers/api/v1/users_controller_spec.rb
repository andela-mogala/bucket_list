require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { FactoryGirl.create :user }
    before { get :show, id: user.id }

    it 'returns the details of a user' do
      user_response = json_response
      expect(user_response[:first_name]).to eq user.first_name
      expect(user_response[:last_name]).to eq user.last_name
      expect(user_response[:email]).to eq user.email
    end

    it 'has a response code indicating success' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:user_attributes) { FactoryGirl.attributes_for :user }
    let!(:initial_user_count) { User.count }

    context 'with valid parameters' do
      before { post :create, user: user_attributes, format: :json }

      it 'creates a user' do
        expect(User.count).to eq initial_user_count + 1
      end

      it 'renders a json response containing user details' do
        user_response = json_response
        expect(user_response[:first_name]).to eq user_attributes[:first_name]
        expect(user_response[:last_name]).to eq user_attributes[:last_name]
        expect(user_response[:email]).to eq user_attributes[:email]
      end

      it 'has a response code indicating success' do
        expect(response.status).to eq 201
      end
    end

    context 'with invalid parameters' do
      before do
        user_attributes[:email] = nil
        post :create, user: user_attributes, format: :json
      end

      it 'does not create a user' do
        expect(User.count).to eq initial_user_count
      end

      it 'renders a json response containing errors' do
        user_response = json_response
        expect(user_response[:errors]).to be_present
      end

      it 'has a response code indicating failure' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PUT/PATCH #update' do
    let(:user) { FactoryGirl.create :user }

    context 'with valid params' do
      before do
        user.email = 'new@example.com'
        patch :update, id: user.id, user: { email: 'new@example.com',
                                            password: user.password
                                          }
      end

      it 'has a json response containing the updated user\'s info' do
        user_response = json_response
        expect(user_response[:email]).to eq 'new@example.com'
      end

      it 'has a response code indicating success' do
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params' do
      before { patch :update, id: user.id, user: { email: 'anything.com' } }

      it 'has a json response contaning errors' do
        user_response = json_response
        expect(user_response[:errors]).to be_present
      end

      it 'has a response code indacting failure' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
  end
end
