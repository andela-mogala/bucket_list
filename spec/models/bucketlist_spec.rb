require 'rails_helper'

RSpec.describe Bucketlist, type: :model do

  describe 'instance methods' do
    it { should respond_to :name }
    it { should respond_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of :name }
  end

  describe 'associations' do
    it { should belong_to :user }
  end
end
