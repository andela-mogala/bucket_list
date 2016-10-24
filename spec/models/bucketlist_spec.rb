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
    it { should have_many :items }
  end

  describe 'class methods' do
    let!(:bucketlist1) { create :bucketlist, name: 'Build a robot' }
    let!(:bucketlist2) { create :bucketlist, name: 'Take over the world' }

    describe '.filter_by_name' do
      it 'returns a matching bucketlist collection' do
        expect(Bucketlist.filter_by_name('build')).to match_array [bucketlist1]
      end
    end

    describe '.recently_added' do
      it 'returns a collection ordered by last created' do
        expect(Bucketlist.recently_added).to match_array(
                                              [bucketlist2, bucketlist1])
      end
    end
  end
end
