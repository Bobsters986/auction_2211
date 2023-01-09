require './lib/attendee'

RSpec.describe Attendee do
  let(:attendee) { Attendee.new(name: "Megan", budget: "$50") }
  
  describe '#initialize' do
    it 'exists' do
      expect(attendee).to be_an(Attendee)
    end

    it 'has attributes' do
      expect(attendee.name).to eq("Megan")
      expect(attendee.budget).to eq(50)
    end
  end
end