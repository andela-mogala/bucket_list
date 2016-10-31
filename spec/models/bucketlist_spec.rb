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
        expect(Bucketlist.recently_added)
          .to match_array([bucketlist2, bucketlist1])
      end
    end

    describe '.search' do
      let!(:bucketlist3) { create :bucketlist, name: 'Build a drone' }

      context 'with names parameter' do
        search_params = { q: 'build' }
        it 'should return collection ordered by creation time' do
          expect(Bucketlist.search(search_params)).to match_array(
            [
              bucketlist3,
              bucketlist1
            ]
          )
        end
      end
    end

    describe '.paginate' do
      before { Bucketlist.destroy_all }
      let(:bucketlists) { create_list :bucketlist, 10 }
      let(:page) { 2 }
      let(:limit) { 2 }

      it 'returns a strict bucketlist collection based on provided params' do
        expect(Bucketlist.paginate(page, limit)).to match_array(
          [bucketlists.third, bucketlists.fourth]
        )
      end
    end
  end
end
