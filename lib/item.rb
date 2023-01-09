class Item
  attr_reader :name,
              :bids

  def initialize(bids = {}, name)
    @name = name
    @bids = bids
  end
end