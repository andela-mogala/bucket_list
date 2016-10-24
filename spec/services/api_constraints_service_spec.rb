require 'rails_helper'

RSpec.describe ApiConstraintsService, type: :service do
  let(:api_constraints_v1) { ApiConstraintsService.new(version: 1)}
  let(:api_constraints_v2) do
    ApiConstraintsService.new(version: 2, default: true)
  end

  describe 'instance methods' do
    describe '#matches?' do
      context 'when version is included in header' do
        let(:request) do
          double(host: ENV['BASE_URL'],
                 headers: {'Accept' => 'application/vnd.mybucket.v1'})
        end

        it 'returns true' do
          expect(api_constraints_v1.matches?(request)).to be true
        end
      end

      context 'when default option is specified' do
        let(:request) { double(host: ENV['BASE_URL']) }

        it 'returns true' do
          expect(api_constraints_v2.matches?(request)).to be true
        end
      end
    end
  end
end