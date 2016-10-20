require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    let(:user_attributes) { FactoryGirl.attributes_for(:user) }

    context 'with valid parameters' do
      let!(:initial_user_count) { User.count }
      before { post :create, user: user_attributes, format: :json }

      it 'should create a user' do
        expect(User.count).to eq initial_user_count + 1
      end

      it 'should render a json response containing user details' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:first_name]).to eq user_attributes[:first_name]
        expect(user_response[:last_name]).to eq user_attributes[:last_name]
        expect(user_response[:email]).to eq user_attributes[:email]
      end

      it 'should have a response code indicating success' do
        expect(response.status).to eq 201
      end
    end
  end
end
