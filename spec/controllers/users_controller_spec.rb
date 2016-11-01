require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    before { get :index }
    it { is_expected.to render_template :index }
    it 'renders with slate layout' do
      expect(response).to render_template(layout: false)
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryGirl.create :user }
    before do
      session[:id] = user.id
      get :show, id: user.id
    end

    it { is_expected.to render_template :show }
  end

  describe 'GET #new' do
    before { get :new }
    it 'should have a new instance of user' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    let(:user_attributes) { FactoryGirl.attributes_for :user }
    let!(:initial_user_count) { User.count }

    context 'with valid parameters' do
      before { post :create, user: user_attributes }

      it 'creates a user' do
        expect(User.count).to eq initial_user_count + 1
      end

      it { is_expected.to redirect_to show_path }
    end

    context 'with invalid parameters' do
      before do
        user_attributes[:email] = nil
        post :create, user: user_attributes
      end

      it 'does not create a user' do
        expect(User.count).to eq initial_user_count
      end

      it { is_expected.to render_template :new }
    end
  end
end
