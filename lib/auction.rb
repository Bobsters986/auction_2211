class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    items.select do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    potential_revenue = 0
    @items.each do |item|
      potential_revenue += item.current_high_bid if !item.bids.empty?
    end
    potential_revenue
  end

  def bidders
    @items.flat_map do |item|
      item.bids.keys
    end.uniq
  end

  def bidder_info
    bidder_info_hash = Hash.new{|h,v| h[v] = {}}
    bidders.each do |bidder|
      bidder_info_hash[bidder]
    end
    bidder_info_hash.sort_by{|key, value| key.budget}

    bidder_info_hash.each do |key, value|
      value[:budget] = key.budget
      value[:items] = []
    end
    bidder_info_hash
  end
end