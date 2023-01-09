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

  def current_high_bid
    bids.sort_by{|k, v| v}
    bids.values.last
  end

end