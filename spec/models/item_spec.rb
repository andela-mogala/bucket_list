require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'instance methods' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :done }
    it { is_expected.to respond_to :bucketlist }
  end

  describe 'associations' do
    it { is_expected.to belong_to :bucketlist }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of :name }
  end
end
