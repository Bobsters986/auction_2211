require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  let(:auction) { Auction.new }

  describe '#initialize' do
    it 'exists' do
      expect(auction).to be_an(Auction)
    end

    it 'has attributes' do
      expect(auction.items).to eq([])
    end
  end
end