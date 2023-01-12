require "date"

class Auction
  attr_reader :items,
              :date

  def initialize
    @items = []
    @date = Date.today.strftime("%d/%m/%Y")
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

  #My original solution
  # def potential_revenue
  #   potential_revenue = 0
  #   @items.each do |item|
  #     potential_revenue += item.current_high_bid if !item.bids.empty?
  #   end
  #   potential_revenue
  # end

  def potential_revenue
    bidded_items = @items - unpopular_items
    bidded_items.sum do |item|
      item.current_high_bid
    end
  end

  # My original solution
  def bidders
    attendee_list = @items.flat_map do |item|
      item.bids.keys
    end.uniq
    attendee_list
  end

#to return name
  # def bidders
  #   attendee_list = @items.flat_map do |item|
  #     item.bids.keys
  #   end.uniq
  #   attendee_list.map do |attendee|
  #     attendee.name
  #   end
  # end

  #My original solution
  # def bidder_info
  #   bidder_info_hash = Hash.new{|h,v| h[v] = {}}
  #   bidders.each do |bidder|
  #     bidder_info_hash[bidder]
  #   end

  #   bidder_info_hash.each do |key, value|
  #     value[:budget] = key.budget
  #     value[:items] = []

  #     items.map do |item|
  #       value[:items] << item if item.bids.include?(key)
  #     end
  #   end

  #   bidder_info_hash.sort_by{|k, v| k.budget}.to_h
  # end

  #Abdul solution
  def bidder_info
    bidder_info_hash = {}

    bidders.each do |attendee|
      bidder_info_hash[attendee] = {
        budget: attendee.budget,
        items: items_by_attendee(attendee)
      }
    end
    bidder_info_hash
  end
#Abdul helper
  def items_by_attendee(attendee)
    @items.select do |item|
      item.bids.keys.include? attendee
    end
  end

  #===================================================================
  def close_auction      #V2, best version if adding more items or attendees
    closing_hash = {}
  
    # Sort the auctions items by highest bid
    items_by_highest_bid = @items.sort_by do |item|
      item.current_high_bid
    end.reverse
  
    # Starting from item with the highest bid
    items_by_highest_bid.each do |item|
      # If no bids -> "Not Sold"
      if item.bids.empty?
        closing_hash[item] = "Not Sold"
      else
        # Now for this item, sort the bidders by bid amount
        # (had to add .to_h at the end because it was returning a nested array)
        bidders_by_bid_amt_desc = item.bids.sort_by do |_, bid_amt|
          bid_amt 
        end.reverse.to_h
  
        # Starting with the highest bidder
        bidders_by_bid_amt_desc.each do |attendee, bid_amt|
          # Do they have enough, if so they get it
          if attendee.budget >= bid_amt
            attendee.budget -= bid_amt
            closing_hash[item] = attendee
            # If this attendee has enough, there is no reason to check the others
            break
          end
        end
      end
    end
    closing_hash
  end

  # def close_auction      V1
  #   hash = {}
    
  #   # Loop through all the items
  #   @items.each do |item|
  #     # Does the item even have any bids, if not, it went unsold
  #     if item.bids.empty?
  #       hash[item] = "Not Sold"
  #     else # If it does have bids...
  #       # Look at all the bids on that item
  #       item.bids.each do |attendee, bid_amt|
  #         # Find all the bids made by that attendee
  #         items_bid_on = items_by_attendee(attendee)
  #         # Sort those items from most to least highest bid
  #         items_bid_on_by_price = items_bid_on.sort_by { |item| item.bids[attendee] }.reverse
  
  #         # Now that this bidders items are in order
  #         # Is their bid the highest for that item?
  #         items_bid_on_by_price.each do |item|
  #           # If the current high bid is equal to their bid then they win it
  #           if item.current_high_bid == item.bids[attendee]
  #             # Add the key/value pair to the hash
  #             hash[item] = attendee
  #             # Reduce their mulah
  #             attendee.budget -= item.current_high_bid
  #             # Check the next item to see if they are the highest bidder given
  #             # their now reduced budget
  #           end
  #         end
  #       end
  #     end
  #   end
  
  #   hash
  # end
  
  private
  
  def items_by_attendee(attendee)
    @items.select do |item|
      item.bids.keys.include?(attendee)
    end
  end

end