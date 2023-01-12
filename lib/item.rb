class Item
  attr_reader :name,
              :bids,
              :available


  def initialize(name)
    @name = name
    @bids = {}
    @available = true
  end

  def add_bid(attendee, bid_amt)
    @bids[attendee] = bid_amt if @available
  end

  #Original soltion that didn't work
  # def current_high_bid
  #   bids.sort_by{|k, v| v}
  #   bids.values.last
  # end

  def current_high_bid
    @bids.values.max
  end

end