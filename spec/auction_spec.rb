require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  let(:auction) { Auction.new }

  describe '#initialize' do
    it 'exists' do
      expect(item1).to be_an(Auction)
    end

    it 'has attributes' do
    end
  end
end