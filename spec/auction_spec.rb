require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  describe 'Iteration 1' do
    let(:auction) { Auction.new }
    let(:attendee) { Attendee.new(name: "Megan", budget: "$50") }
    let(:item1) { Item.new('Chalkware Piggy Bank') }
    let(:item2) { Item.new('Bamboo Picture Frame') }

    describe '#initialize' do
      it 'exists' do
        expect(auction).to be_an(Auction)
      end

      it 'has attributes' do
        expect(auction.items).to eq([])
      end
    end

    describe '#add_items and return #item_names' do
      it 'can add items to empty items array' do
        auction.add_item(item1)
        auction.add_item(item2)

        expect(auction.items).to eq([item1, item2])
      end

      it 'can return item names in items array' do
        auction.add_item(item1)
        auction.add_item(item2)

        expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
      end
    end
  end

  describe 'Iteration 2' do
    let(:auction) { Auction.new }
    let(:attendee1) { Attendee.new(name: "Megan", budget: "$50") }
    let(:attendee2) { Attendee.new(name: "Bob", budget: "$75") }
    let(:attendee3) { Attendee.new(name: "Mike", budget: "$100") }
    let(:item1) { Item.new('Chalkware Piggy Bank') }
    let(:item2) { Item.new('Bamboo Picture Frame') }
    let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
    let(:item4) { Item.new('2 Days Dogsitting') }
    let(:item5) { Item.new('Forever Stamps') }

    describe 'each item starts with an empty bids hash, and adds bids to each item' do
      before do
        auction.add_item(item1)
        auction.add_item(item2)
        auction.add_item(item3)
        auction.add_item(item4)
        auction.add_item(item5)
      end
      
      it 'has no #bids, then #add_bid' do
        expect(item1.bids).to eq({})

        item1.add_bid(attendee2, 20)
        item1.add_bid(attendee1, 22)

        expected = {
          attendee2 => 20,
          attendee1 => 22
        }

        expect(item1.bids).to eq(expected)
      end

      it '#current_high_bid' do
        item1.add_bid(attendee2, 20)
        item1.add_bid(attendee1, 22)

        expect(item1.current_high_bid).to eq(22)
      end

      it 'returns an array of #unpopular_items' do
        item1.add_bid(attendee2, 20)
        item1.add_bid(attendee1, 22)
        item4.add_bid(attendee3, 50)

        expect(auction.unpopular_items).to eq([item2, item3, item5])
      end

    end
  end

end