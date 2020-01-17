# The term “tab” is short for “tabulation.” When used in a bar or restaurant and the server says they are adding something to your “tab,” they are really saying “let me add that to the tabulation for your bill.”

# Rooms can keep track of the entry fees/spending of the guests - maybe add a bar tab/bar class?



class Bar

  def initialize()
    # initialize with a default hash of alko names as keys and
    # hashes containing default stock(in serving units) and unit price:
    @bar_stock = {
      "vodka" => {stock: 100, price: 4.50},
      "beer" => {stock: 100, price: 3.50},
      "cider" => {stock: 100, price: 3.70}
    }

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
      end
        return "Sorry, but you can't afford it."
    end
      return "This drink is not available at the moment."
  end

  def check_till
    return @bar_till
  end

  def check_stock(drink_name_str)
    return @bar_stock[drink_name_str][:stock]
  end




end
