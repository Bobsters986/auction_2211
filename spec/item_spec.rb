require './lib/item'

RSpec.describe Item do
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  describe '#initialize' do
    it 'exists' do
      expect(item1).to be_an(Item)
    end

    it 'has attributes' do
      expect(item1.name).to eq('Chalkware Piggy Bank')
    end
  end
end