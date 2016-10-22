require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'instance methods' do
    it { should respond_to :name }
    it { should respond_to :done }
    it { should respond_to :bucketlist }
  end

  describe 'associations' do
    it { should belong_to :bucketlist }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of :name }
  end
end
