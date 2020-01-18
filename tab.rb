# The term “tab” is short for “tabulation.” When used in a bar or restaurant and the server says they are adding something to your “tab,” they are really saying “let me add that to the tabulation for your bill.” - In our case tab adding drinks to tab for different customer, will assume that the money is exchanged as soon as the drink is purchased. Tab here will be for reporting purposes to report on the amount of drinks each guest purchases.

# Rooms can keep track of the entry fees/spending of the guests - maybe add a bar tab/bar class?

# require 'pry'

class Bar

  def initialize()
    # initialize with a default hash of alko names as keys and
    # hashes containing default stock(in serving units) and unit price:
    @bar_stock = {
      "vodka" => {stock: 100, price: 4.50},
      "beer" => {stock: 100, price: 3.50},
      "cider" => {stock: 100, price: 3.70}
    }


    # tab hash will hold guest objects as keys that point to
    # a hash which has name key pointing to guest_objects name variable, and a drinks_bought key pointing to a hash with drink names as keyes and purchased units as values:

    # example_tab = {@guest_1 => {name: @guest_1.guest_name,
    #                            drinks_bought: {"vodka" => 1, "beer" => 2}},
    #               @guest_2 => {name: @guest_2.guest_name,
    #                           drinks_bought: {"vodka" => 5, "beer" => 1}},
    #               @guest_3 => {name: @guest_3.guest_name,
    #                            drinks_bought: {"cider" => 5, "beer" => 1}}
    #                         }



    @tab = {}

    @bar_till = 0.00

  end

  def sell_a_drink(guest_obj, drink_name_str)
    # availability check
    if @bar_stock.has_key?(drink_name_str) && @bar_stock[drink_name_str][:stock] > 0
      # money_check
      if guest_obj.check_wallet >= @bar_stock[drink_name_str][:price]
        # money out for customer
        guest_obj.pay(@bar_stock[drink_name_str][:price])
        # money in for bar
        @bar_till += @bar_stock[drink_name_str][:price]
        # reduce stock
        @bar_stock[drink_name_str][:stock] -= 1
        # add to tab
        add_drink_to_tab(guest_obj, drink_name_str)
      end
        return "Sorry, but you can't afford it."
    end
      return "This drink is not available at the moment."
  end


  def add_drink_to_tab(guest_obj, drink_name_str)

    guest_obj_hash_1_buy = {name: guest_obj.guest_name,
            drinks_bought: {drink_name_str => 1}
           }

    if @tab.has_key?(guest_obj)
      if @tab[guest_obj][:drinks_bought].has_key?(drink_name_str)
         @tab[guest_obj][:drinks_bought][drink_name_str] += 1
      else
        @tab[guest_obj][:drinks_bought][drink_name_str] = 1
      end

    else
      @tab[guest_obj] = guest_obj_hash_1_buy
    end
  end


  def check_bar_till
    return @bar_till
  end

  def check_bar_tab(guest_obj)
    return @tab[guest_obj]
  end

  def check_bar_stock(drink_name_str)
    return @bar_stock[drink_name_str][:stock]
  end




end
