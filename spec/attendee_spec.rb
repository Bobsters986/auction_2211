require './lib/attendee'

RSpec.describe Attendee do
  let(:attendee) { Attendee.new(name: 'Megan', budget: '$50') }
  
  describe '#initialize' do
    it 'exists' do
      expect(attendee).to be_an(Attendee)
    end

    xit 'has attributes' do
      
    end
  end
end