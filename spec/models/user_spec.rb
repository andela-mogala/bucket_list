require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to respond_to :first_name }
  it { is_expected.to respond_to :last_name }
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :password }
  it { is_expected.to respond_to :password_confirmation }
  it { is_expected.to respond_to :auth_token }
  it { is_expected.to respond_to :generate_token_and_update }
  it { is_expected.to respond_to :token_expired? }

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to validate_length_of :password }
    it { is_expected.to validate_confirmation_of :password }
  end

  describe 'associations' do
    it { is_expected.to have_many :bucketlists }
  end

  describe 'bucketlist dependence' do
    let(:user) { create :user }
    let(:bucketlist) { create :bucketlist, user: user }

    context 'when user is deleted' do
      before { user.destroy }
      it 'deletes related bucketlist' do
        expect(user.bucketlists.first).to be_nil
      end
    end
  end

  describe 'instance methods' do
    let(:user) { create :user }

    describe '#generate_token_and_update' do
      it 'has an auth_token' do
        expect(user.auth_token).to_not be_nil
      end
    end
  end
end
