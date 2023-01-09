class Item
  attr_reader :name,
              :bids

  def initialize(bids = {}, name)
    @name = name
    @bids = bids
  end

  def add_bid(attendee, bid)
    @bids[attendee] = bid
  end

end